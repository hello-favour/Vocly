import 'dart:convert';

class UpgradeDialogue {
  const UpgradeDialogue({required this.label, required this.lines});

  final String label;
  final List<String> lines;

  factory UpgradeDialogue.fromJsonValue(
    dynamic value, {
    required String fallbackLabel,
  }) {
    if (value is String) {
      try {
        return UpgradeDialogue.fromJsonValue(
          jsonDecode(value),
          fallbackLabel: fallbackLabel,
        );
      } on FormatException {
        return UpgradeDialogue(label: fallbackLabel, lines: [value]);
      }
    }

    if (value is List) {
      return UpgradeDialogue(
        label: fallbackLabel,
        lines: value.map((line) => line.toString()).toList(),
      );
    }

    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      final rawLines = map['lines'] ?? map['dialogue'] ?? const [];
      return UpgradeDialogue(
        label: map['label'] as String? ?? fallbackLabel,
        lines: rawLines is List
            ? rawLines.map((line) => line.toString()).toList()
            : [rawLines.toString()],
      );
    }

    return UpgradeDialogue(label: fallbackLabel, lines: const []);
  }
}

class UpgradeCard {
  const UpgradeCard({
    required this.id,
    required this.domain,
    required this.level,
    required this.basicPhrase,
    required this.proPhrase,
    required this.upgradeLabel,
    required this.contextDialogue1,
    required this.contextDialogue2,
    required this.whenToUse,
    required this.whenNotToUse,
    required this.register,
    this.audioBasicUrl,
    this.audioProUrl,
  });

  final String id;
  final String domain;
  final String level;
  final String basicPhrase;
  final String proPhrase;
  final String upgradeLabel;
  final UpgradeDialogue contextDialogue1;
  final UpgradeDialogue contextDialogue2;
  final String whenToUse;
  final String whenNotToUse;
  final String register;
  final String? audioBasicUrl;
  final String? audioProUrl;

  String get domainLabel => switch (domain) {
    'smart_replies' => 'Smart replies',
    'grammar_fix' => 'Grammar fix',
    'professional' => 'Professional',
    'social' => 'Social',
    'interview' => 'Interview',
    _ => domain,
  };

  factory UpgradeCard.fromJson(Map<String, dynamic> json) => UpgradeCard(
    id: json['id'] as String,
    domain: json['domain'] as String,
    level: json['level'] as String,
    basicPhrase: json['basic_phrase'] as String,
    proPhrase: json['pro_phrase'] as String,
    upgradeLabel: json['upgrade_label'] as String,
    contextDialogue1: UpgradeDialogue.fromJsonValue(
      json['context_dialogue_1'],
      fallbackLabel: 'At work',
    ),
    contextDialogue2: UpgradeDialogue.fromJsonValue(
      json['context_dialogue_2'],
      fallbackLabel: 'In conversation',
    ),
    whenToUse: json['when_to_use'] as String,
    whenNotToUse: json['when_not_to_use'] as String,
    register: json['register'] as String,
    audioBasicUrl: json['audio_basic_url'] as String?,
    audioProUrl: json['audio_pro_url'] as String?,
  );
}
