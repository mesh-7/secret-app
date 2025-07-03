import 'package:flutter/material.dart';

/// A temporary login screen scaffold that will later integrate biometric
/// authentication. For now it simply shows a placeholder button.
import 'package:secure_vault/services/biometric_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, BiometricService? biometricService})
      : _biometricService = biometricService ?? BiometricService(),
        super(key: key);

  final BiometricService _biometricService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final ok = await _biometricService.authenticate();
            if (!context.mounted) return;
            if (ok) {
              Navigator.of(context).pushReplacementNamed('/vault_list');
            }
          },
          child: const Text('Authenticate'),
        ),
      ),
    );
  }
}
