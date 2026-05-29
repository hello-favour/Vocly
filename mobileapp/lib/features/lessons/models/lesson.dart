class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.word,
    required this.wordDefinition,
    required this.wordExample,
    required this.phrase,
    required this.phraseMeaning,
    required this.grammarRule,
    required this.grammarExample,
    required this.level,
    this.audioUrl,
  });

  final String id;
  final String title;
  final String word;
  final String wordDefinition;
  final String wordExample;
  final String phrase;
  final String phraseMeaning;
  final String grammarRule;
  final String grammarExample;
  final String level;
  final String? audioUrl;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    id: json['id'] as String,
    title: json['title'] as String,
    word: json['word'] as String,
    wordDefinition: json['word_definition'] as String,
    wordExample: json['word_example'] as String,
    phrase: json['phrase'] as String,
    phraseMeaning: json['phrase_meaning'] as String,
    grammarRule: json['grammar_rule'] as String,
    grammarExample: json['grammar_example'] as String,
    level: json['level'] as String,
    audioUrl: json['audio_url'] as String?,
  );
}
