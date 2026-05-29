create extension if not exists "uuid-ossp";

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  avatar_url text,
  goal text check (goal in ('professional', 'academic', 'social', 'travel')) default 'professional',
  skill_level text check (skill_level in ('beginner', 'intermediate', 'advanced')),
  daily_goal_mins integer not null default 10,
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
create policy "Users can update own profile" on public.profiles for update using (auth.uid() = id);

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

create table public.lessons (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  word text not null,
  word_definition text not null,
  word_example text not null,
  phrase text not null,
  phrase_meaning text not null,
  grammar_rule text not null,
  grammar_example text not null,
  level text check (level in ('beginner', 'intermediate', 'advanced')) not null,
  category text not null default 'general',
  audio_url text,
  published_at date not null default current_date,
  created_at timestamptz not null default now()
);

alter table public.lessons enable row level security;
create policy "Authenticated users can read lessons" on public.lessons for select to authenticated using (true);

create table public.user_lesson_progress (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  completed_at timestamptz not null default now(),
  unique(user_id, lesson_id)
);

alter table public.user_lesson_progress enable row level security;
create policy "Users read own lesson progress" on public.user_lesson_progress for select using (auth.uid() = user_id);
create policy "Users insert own lesson progress" on public.user_lesson_progress for insert with check (auth.uid() = user_id);

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
  audio_path text not null,
  score_overall numeric(5,2),
  score_json jsonb,
  created_at timestamptz not null default now()
);

alter table public.pronunciation_history enable row level security;
create policy "Users read own pronunciation history" on public.pronunciation_history for select using (auth.uid() = user_id);
create policy "Users insert own pronunciation history" on public.pronunciation_history for insert with check (auth.uid() = user_id);

create table public.daily_usage_log (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  log_date date not null default current_date,
  unique(user_id, log_date)
);

alter table public.daily_usage_log enable row level security;
create policy "Users read own usage log" on public.daily_usage_log for select using (auth.uid() = user_id);
create policy "Users insert own usage log" on public.daily_usage_log for insert with check (auth.uid() = user_id);

create or replace function public.update_streak(p_user_id uuid)
returns void language plpgsql security definer as $$
declare
  v_last_date date;
  v_freeze integer;
begin
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
