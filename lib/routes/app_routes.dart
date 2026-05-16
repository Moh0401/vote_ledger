import 'package:flutter/material.dart';
import '../features/auth/domain/entities/agent_entity.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/vote/presentation/screens/form_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/vote/presentation/screens/capture_pv_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: settings,
        );
      case '/form':
        return MaterialPageRoute(
          builder: (_) => const FormScreen(),
          settings: settings,
        );
      case '/profile':
        if (args is AgentEntity) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(agent: args),
          );
        }
        // Fallback or error handling if agent is missing
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/capture-pv':
        return MaterialPageRoute(builder: (_) => const CapturePvScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
