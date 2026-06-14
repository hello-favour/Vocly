class AppRoutes {
  AppRoutes._();

  static const root = '/';
  static const authSplash = '/auth/splash';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const forgotPassword = '/auth/forgot-password';
  static const resetPassword = '/auth/reset-password';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const lessonsTab = '/home/lessons';
  static const pronunciationTab = '/home/pronunciation';
  static const profileTab = '/home/profile';
  static const upgradeDetail = '/upgrades/:id';
  static const writingResult = '/writing/result';
  static const writingHistory = '/writing/history';
  static const pronunciationResult = '/pronunciation/result';
  static const paywall = '/paywall';

  static String homeTab(String tab) => '$home/$tab';
  static String upgrade(String id) => '/upgrades/$id';
}
