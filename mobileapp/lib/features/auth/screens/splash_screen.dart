import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(AppRoutes.register);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text(
          'V',
          style: TextStyle(
            color: Colors.white,
            fontSize: 72,
            fontWeight: FontWeight.w700,
            fontFamily: 'Fraunces',
          ),
        ),
      ),
    );
  }
}
