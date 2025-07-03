import 'package:flutter/material.dart';
import 'package:secure_vault/ui/screens/login_screen.dart';
import 'package:secure_vault/ui/screens/vault_list_screen.dart';
import 'package:secure_vault/ui/screens/item_detail_screen.dart';
import 'package:secure_vault/ui/screens/settings_screen.dart';

/// Root widget configuring MaterialApp and initial routes.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureVault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginScreen(),
        '/vault_list': (_) => const VaultListScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
      // Handle dynamic routes such as /item/<id>
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'item') {
          final id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => ItemDetailScreen(id: id),
            settings: settings,
          );
        }
        return null; // Unknown route handled elsewhere
      },
    );
  }
}
