import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_routes.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/lessons/screens/lesson_detail_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/paywall/screens/paywall_screen.dart';
import '../features/profile/screens/coins_screen.dart';
import '../features/profile/screens/settings_screen.dart';
import '../features/pronunciation/screens/pronunciation_result_screen.dart';
import '../features/session/app_session_provider.dart';
import '../features/writing/models/feedback_result.dart';
import '../features/writing/screens/writing_history_screen.dart';
import '../features/writing/screens/writing_result_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final session = ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

  return GoRouter(
    initialLocation: AppRoutes.lessonsTab,
    refreshListenable: _RouterRefresh(ref),
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthRoute = path.startsWith('/auth');
      final isOnboarding = path == AppRoutes.onboarding;

      if (!session.isSignedIn && !isAuthRoute) {
        return AppRoutes.authSplash;
      }
      if (session.isSignedIn && !session.onboardingComplete && !isOnboarding) {
        return AppRoutes.onboarding;
      }
      if (session.isSignedIn &&
          session.onboardingComplete &&
          (isAuthRoute || isOnboarding)) {
        return AppRoutes.lessonsTab;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.root,
        redirect: (context, state) => AppRoutes.lessonsTab,
      ),
      GoRoute(
        path: AppRoutes.authSplash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.home}/:tab',
        builder: (context, state) =>
            HomeScreen(tab: state.pathParameters['tab'] ?? 'lessons'),
      ),
      GoRoute(
        path: AppRoutes.lessonDetail,
        builder: (context, state) =>
            LessonDetailScreen(lessonId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.writingResult,
        builder: (context, state) =>
            WritingResultScreen(result: state.extra! as FeedbackResult),
      ),
      GoRoute(
        path: AppRoutes.writingHistory,
        builder: (context, state) => const WritingHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.pronunciationResult,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? const {};
          return PronunciationResultScreen(
            word: extra['word'] as String? ?? 'clarity',
            score: extra['score'] as int? ?? 78,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.paywall,
        builder: (context, state) =>
            PaywallScreen(trigger: state.extra as String?),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.coins,
        builder: (context, state) => const CoinsScreen(),
      ),
    ],
  );
});

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(this.ref) {
    sub = ref.listen(appSessionProvider, (previous, next) => notifyListeners());
  }

  final Ref ref;
  late final ProviderSubscription<AsyncValue<AppSession>> sub;

  @override
  void dispose() {
    sub.close();
    super.dispose();
  }
}
