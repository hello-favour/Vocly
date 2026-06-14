create extension if not exists "uuid-ossp";

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  avatar_url text,
  goal text check (goal in ('professional', 'social', 'interview', 'all')) default 'professional',
  skill_level text check (skill_level in ('beginner', 'intermediate', 'advanced')),
  daily_goal_mins integer not null default 10,
  onboarding_done boolean not null default false,
  coins integer not null default 0,
  streak_count integer not null default 0,
  streak_freeze integer not null default 0,
  last_active_date date,
  is_pro boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "Users can view own profile" on public.profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on public.profiles
  for update using (auth.uid() = id) with check (auth.uid() = id);

revoke update on public.profiles from anon, authenticated;
grant update (
  display_name,
  avatar_url,
  goal,
  skill_level,
  daily_goal_mins,
  onboarding_done,
  updated_at
) on public.profiles to authenticated;

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', ''));
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

create table public.upgrade_cards (
  id uuid primary key default uuid_generate_v4(),
  domain text check (domain in (
    'professional', 'social', 'interview', 'smart_replies', 'grammar_fix'
  )) not null,
  level text check (level in ('beginner', 'intermediate', 'advanced')) not null,
  basic_phrase text not null,
  pro_phrase text not null,
  upgrade_label text not null,
  context_dialogue_1 jsonb not null,
  context_dialogue_2 jsonb not null,
  when_to_use text not null,
  when_not_to_use text not null,
  register text not null,
  audio_basic_url text,
  audio_pro_url text,
  published_at date not null default current_date,
  created_at timestamptz not null default now()
);

alter table public.upgrade_cards enable row level security;
create policy "Authenticated users read upgrade cards"
  on public.upgrade_cards for select to authenticated using (true);

create table public.user_card_progress (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  card_id uuid not null references public.upgrade_cards(id) on delete cascade,
  completed_at timestamptz not null default now(),
  unique(user_id, card_id)
);

alter table public.user_card_progress enable row level security;
create policy "Users read own card progress"
  on public.user_card_progress for select using (auth.uid() = user_id);

create table public.phrase_bank (
  id uuid primary key default uuid_generate_v4(),
  category text not null,
  basic_phrase text not null,
  pro_phrase text not null,
  meaning text,
  context_note text,
  example_usage text,
  audio_url text,
  is_premium boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.phrase_bank enable row level security;
create policy "Users read available phrases"
  on public.phrase_bank for select to authenticated
  using (
    is_premium = false or exists (
      select 1 from public.profiles
      where id = auth.uid() and is_pro = true
    )
  );

create table public.situation_scenarios (
  id uuid primary key default uuid_generate_v4(),
  situation text not null,
  prompt text not null,
  prompt_context text not null,
  difficulty text check (difficulty in ('easy', 'medium', 'hard')) not null default 'medium',
  created_at timestamptz not null default now()
);

alter table public.situation_scenarios enable row level security;
create policy "Authenticated users read scenarios"
  on public.situation_scenarios for select to authenticated using (true);

create table public.situation_sessions (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  scenario_id uuid references public.situation_scenarios(id),
  situation_type text not null,
  user_input text not null,
  ai_feedback jsonb not null,
  overall_score integer,
  created_at timestamptz not null default now()
);

alter table public.situation_sessions enable row level security;
create policy "Users read own situation sessions"
  on public.situation_sessions for select using (auth.uid() = user_id);
create policy "Users insert own situation sessions"
  on public.situation_sessions for insert with check (auth.uid() = user_id);

create table public.quiz_questions (
  id uuid primary key default uuid_generate_v4(),
  question_type text check (question_type in (
    'basic_or_pro', 'choose_better', 'correct_grammar', 'fill_upgrade'
  )) not null,
  question_text text not null,
  option_a text not null,
  option_b text,
  option_c text,
  correct_answer text not null,
  explanation text not null,
  domain text not null,
  created_at timestamptz not null default now()
);

alter table public.quiz_questions enable row level security;
create policy "Authenticated users read quiz questions"
  on public.quiz_questions for select to authenticated using (true);

create table public.quiz_attempts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  question_id uuid not null references public.quiz_questions(id) on delete cascade,
  session_id uuid not null default uuid_generate_v4(),
  selected_answer text not null,
  is_correct boolean not null,
  answered_at timestamptz not null default now()
);

alter table public.quiz_attempts enable row level security;
create policy "Users read own quiz attempts"
  on public.quiz_attempts for select using (auth.uid() = user_id);
create policy "Users insert own quiz attempts"
  on public.quiz_attempts for insert with check (auth.uid() = user_id);

create table public.ai_feedback_history (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  original_text text not null,
  feedback_json jsonb not null,
  created_at timestamptz not null default now()
);

alter table public.ai_feedback_history enable row level security;
create policy "Users read own feedback history" on public.ai_feedback_history for select using (auth.uid() = user_id);
create policy "Users insert own feedback" on public.ai_feedback_history for insert with check (auth.uid() = user_id);

create table public.pronunciation_history (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  word text not null,
  audio_path text,
  score_overall numeric(5,2),
  score_json jsonb,
  created_at timestamptz not null default now()
);

alter table public.pronunciation_history enable row level security;
create policy "Users read own pronunciation history" on public.pronunciation_history for select using (auth.uid() = user_id);

create table public.daily_usage_log (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  log_date date not null default current_date,
  unique(user_id, log_date)
);

alter table public.daily_usage_log enable row level security;
create policy "Users read own usage log" on public.daily_usage_log for select using (auth.uid() = user_id);
create policy "Users insert own usage log" on public.daily_usage_log for insert with check (auth.uid() = user_id);

create or replace function public.count_today_cards(p_user_id uuid)
returns integer language sql security definer set search_path = public as $$
  select count(*)::integer
  from public.user_card_progress
  where user_id = p_user_id and completed_at::date = current_date;
$$;

create or replace function public.count_today_situations(p_user_id uuid)
returns integer language sql security definer set search_path = public as $$
  select count(*)::integer
  from public.situation_sessions
  where user_id = p_user_id and created_at::date = current_date;
$$;

create or replace function public.count_today_quizzes(p_user_id uuid)
returns integer language sql security definer set search_path = public as $$
  select count(distinct session_id)::integer
  from public.quiz_attempts
  where user_id = p_user_id and answered_at::date = current_date;
$$;

create or replace function public.count_today_pronunciation(p_user_id uuid)
returns integer language sql security definer set search_path = public as $$
  select count(*)::integer
  from public.pronunciation_history
  where user_id = p_user_id and created_at::date = current_date;
$$;

create or replace function public.update_streak(p_user_id uuid)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_last_date date;
  v_freeze integer;
begin
  if coalesce(auth.jwt()->>'role', '') <> 'service_role'
     and auth.uid() is distinct from p_user_id then
    raise exception 'Not authorized';
  end if;

  select last_active_date, streak_freeze
  into v_last_date, v_freeze
  from public.profiles
  where id = p_user_id;

  insert into public.daily_usage_log (user_id, log_date)
  values (p_user_id, current_date)
  on conflict (user_id, log_date) do nothing;

  if v_last_date is null then
    update public.profiles set streak_count = 1, last_active_date = current_date, updated_at = now() where id = p_user_id;
  elsif v_last_date = current_date then
    return;
  elsif v_last_date = current_date - interval '1 day' then
    update public.profiles set streak_count = streak_count + 1, last_active_date = current_date, updated_at = now() where id = p_user_id;
  elsif v_last_date = current_date - interval '2 days' and v_freeze > 0 then
    update public.profiles
    set streak_count = streak_count + 1, streak_freeze = streak_freeze - 1, last_active_date = current_date, updated_at = now()
    where id = p_user_id;
  else
    update public.profiles set streak_count = 1, last_active_date = current_date, updated_at = now() where id = p_user_id;
  end if;
end;
$$;

revoke execute on function public.count_today_cards(uuid) from public, anon, authenticated;
revoke execute on function public.count_today_situations(uuid) from public, anon, authenticated;
revoke execute on function public.count_today_quizzes(uuid) from public, anon, authenticated;
revoke execute on function public.count_today_pronunciation(uuid) from public, anon, authenticated;
grant execute on function public.count_today_cards(uuid) to service_role;
grant execute on function public.count_today_situations(uuid) to service_role;
grant execute on function public.count_today_quizzes(uuid) to service_role;
grant execute on function public.count_today_pronunciation(uuid) to service_role;

revoke execute on function public.update_streak(uuid) from public, anon;
grant execute on function public.update_streak(uuid) to authenticated;
