import '../../../config/supabase_config.dart';
import '../models/lesson.dart';

class LessonsRepository {
  Future<List<Lesson>> todaysLessons(String level) async {
    final client = SupabaseConfig.maybeClient;
    if (client == null) {
      return _demoLessons.where((lesson) => lesson.level == level).toList();
    }

    final rows = await client
        .from('lessons')
        .select()
        .eq('level', level)
        .order('published_at', ascending: false)
        .limit(3);
    return (rows as List)
        .map((row) => Lesson.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  Future<void> completeLesson(String lessonId) async {
    final client = SupabaseConfig.maybeClient;
    final user = client?.auth.currentUser;
    if (client == null || user == null) {
      return;
    }

    await client.from('user_lesson_progress').upsert({
      'user_id': user.id,
      'lesson_id': lessonId,
    });
    await client.rpc('update_streak', params: {'p_user_id': user.id});
    await client.from('profiles').update({'coins': 10}).eq('id', user.id);
  }
}

const _demoLessons = [
  Lesson(
    id: 'intermediate-clarity',
    title: 'Client-ready clarity',
    word: 'concise',
    wordDefinition: 'Giving information clearly in a few words.',
    wordExample: 'Please send a concise update before the client call.',
    phrase: 'To be aligned',
    phraseMeaning: 'To share the same understanding or plan with someone.',
    grammarRule: 'Use “fewer” for countable things and “less” for amounts.',
    grammarExample: 'Correct: We need fewer revisions and less confusion.',
    level: 'intermediate',
  ),
  Lesson(
    id: 'beginner-polish',
    title: 'Polite workplace basics',
    word: 'confirm',
    wordDefinition: 'To say that something is correct or agreed.',
    wordExample: 'Can you confirm the meeting time?',
    phrase: 'I would like to',
    phraseMeaning: 'A polite way to say what you want.',
    grammarRule:
        'Use “a” before consonant sounds and “an” before vowel sounds.',
    grammarExample: 'Correct: an update, a report.',
    level: 'beginner',
  ),
  Lesson(
    id: 'advanced-precision',
    title: 'Executive precision',
    word: 'substantiate',
    wordDefinition: 'To support a claim with evidence or facts.',
    wordExample: 'Please substantiate the forecast with last quarter’s data.',
    phrase: 'For context',
    phraseMeaning: 'A concise way to add background before your main point.',
    grammarRule: 'Keep parallel structure in lists.',
    grammarExample: 'Correct: The plan is clear, practical, and measurable.',
    level: 'advanced',
  ),
];
