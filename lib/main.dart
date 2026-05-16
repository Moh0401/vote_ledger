import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const VoteLedgerApp());
}

class VoteLedgerApp extends StatelessWidget {
  const VoteLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VoteLedger',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
      ),

      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}