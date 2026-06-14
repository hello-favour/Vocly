import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../session/app_session_provider.dart';
import '../data/upgrade_cards_repository.dart';
import '../models/upgrade_card.dart';

final upgradeCardsRepositoryProvider = Provider(
  (ref) => UpgradeCardsRepository(),
);

final todaysUpgradeCardsProvider = FutureProvider<List<UpgradeCard>>((ref) {
  final session = ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
  return ref
      .watch(upgradeCardsRepositoryProvider)
      .todaysCards(
        level: session.skillLevel,
        domain: _domainForGoal(session.goal),
      );
});

final upgradeCardByIdProvider = Provider.family<UpgradeCard?, String>((
  ref,
  id,
) {
  final cards =
      ref.watch(todaysUpgradeCardsProvider).valueOrNull ??
      const <UpgradeCard>[];
  return cards.where((card) => card.id == id).firstOrNull;
});

String _domainForGoal(String goal) => switch (goal) {
  'social' => 'social',
  'interview' => 'interview',
  _ => 'professional',
};
