class AppRoutes {
  AppRoutes._();

  static const root = '/';
  static const authSplash = '/auth/splash';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const lessonsTab = '/home/lessons';
  static const writingTab = '/home/writing';
  static const pronunciationTab = '/home/pronunciation';
  static const progressTab = '/home/progress';
  static const profileTab = '/home/profile';
  static const lessonDetail = '/lessons/:id';
  static const writingResult = '/writing/result';
  static const writingHistory = '/writing/history';
  static const pronunciationResult = '/pronunciation/result';
  static const paywall = '/paywall';
  static const settings = '/settings';
  static const coins = '/coins';

  static String homeTab(String tab) => '$home/$tab';
  static String lesson(String id) => '/lessons/$id';
}
