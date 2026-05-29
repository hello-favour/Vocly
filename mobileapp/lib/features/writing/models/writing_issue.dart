class WritingIssue {
  const WritingIssue({
    required this.type,
    required this.original,
    required this.suggestion,
    required this.explanation,
  });

  final String type;
  final String original;
  final String suggestion;
  final String explanation;

  factory WritingIssue.fromJson(Map<String, dynamic> json) => WritingIssue(
    type: json['type'] as String,
    original: json['original'] as String,
    suggestion: json['suggestion'] as String,
    explanation: json['explanation'] as String,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'original': original,
    'suggestion': suggestion,
    'explanation': explanation,
  };
}
