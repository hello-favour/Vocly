import 'writing_issue.dart';

class FeedbackResult {
  const FeedbackResult({
    required this.original,
    required this.corrected,
    required this.tone,
    required this.issues,
    required this.overallScore,
    required this.confidenceTip,
    required this.summary,
  });

  final String original;
  final String corrected;
  final String tone;
  final List<WritingIssue> issues;
  final int overallScore;
  final String confidenceTip;
  final String summary;

  factory FeedbackResult.fromJson(
    Map<String, dynamic> json, {
    String original = '',
  }) => FeedbackResult(
    original: original,
    corrected: json['corrected'] as String,
    tone: json['tone'] as String,
    issues: (json['issues'] as List)
        .map((e) => WritingIssue.fromJson(e as Map<String, dynamic>))
        .toList(),
    overallScore: json['overall_score'] as int,
    confidenceTip: json['confidence_tip'] as String,
    summary: json['summary'] as String,
  );

  Map<String, dynamic> toJson() => {
    'corrected': corrected,
    'tone': tone,
    'issues': issues.map((issue) => issue.toJson()).toList(),
    'overall_score': overallScore,
    'confidence_tip': confidenceTip,
    'summary': summary,
  };
}
