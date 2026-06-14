import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_routes.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/lessons/screens/lesson_detail_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/paywall/screens/paywall_screen.dart';
import '../features/pronunciation/screens/pronunciation_result_screen.dart';
import '../features/session/app_session_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final session = ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

  return GoRouter(
    initialLocation: AppRoutes.authSplash,
    refreshListenable: _RouterRefresh(ref),
    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthRoute = path.startsWith('/auth');
      final isOnboarding = path == AppRoutes.onboarding;
      final isPasswordReset = path == AppRoutes.resetPassword;

      if (!session.isSignedIn && !isAuthRoute) {
        return AppRoutes.authSplash;
      }
      if (session.isSignedIn &&
          !session.onboardingComplete &&
          !isOnboarding &&
          !isPasswordReset) {
        return AppRoutes.onboarding;
      }
      if (session.isSignedIn &&
          session.onboardingComplete &&
          (isAuthRoute || isOnboarding) &&
          !isPasswordReset) {
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
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.home}/:tab',
        redirect: (context, state) {
          const tabs = {'lessons', 'pronunciation', 'profile'};
          final tab = state.pathParameters['tab'];
          return tabs.contains(tab) ? null : AppRoutes.lessonsTab;
        },
        builder: (context, state) =>
            HomeScreen(tab: state.pathParameters['tab'] ?? 'lessons'),
      ),
      GoRoute(
        path: AppRoutes.upgradeDetail,
        builder: (context, state) =>
            LessonDetailScreen(lessonId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.pronunciationResult,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? const {};
          return PronunciationResultScreen(
            word: extra['word'] as String? ?? 'Practice phrase',
            score: extra['score'] as int? ?? 0,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.paywall,
        builder: (context, state) =>
            PaywallScreen(trigger: state.extra as String?),
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
