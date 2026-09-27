import 'package:flutter/material.dart';

import 'shell/app_shell.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ByAllMeansApp());
}

class ByAllMeansApp extends StatelessWidget {
  const ByAllMeansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BY EVERY MEANS | Strategy & Design',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
