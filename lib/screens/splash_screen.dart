import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/features/authentication/authentication_view.dart';
import 'package:flutter_project/features/dashboard/dashboard_view.dart';
import 'package:flutter_project/services/user_cache_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState {
  double progressValue = 0.0;
  @override
  void initState() {
    final userCacheService = ref.read(userCacheProvider);

    final timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        progressValue += 1;
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      timer.cancel();
      Navigator.pushNamedAndRemoveUntil(
        context,
        userCacheService.user != null
            ? DashboardView.routeName
            : AuthenticationView.routeName,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Riverpod\nMVVM'.toUpperCase(),
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: 180.0,
              child: LinearProgressIndicator(
                value: progressValue / 100,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
