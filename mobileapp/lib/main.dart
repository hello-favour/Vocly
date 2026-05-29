import 'package:flutter/material.dart';

import 'app.dart';
import 'config/supabase_config.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();
  await NotificationService.init();
  runApp(const FluentAiApp());
}
