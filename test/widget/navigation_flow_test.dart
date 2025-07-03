import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/ui/screens/login_screen.dart';
import 'package:secure_vault/services/biometric_service.dart';
import 'package:secure_vault/ui/screens/vault_list_screen.dart';

class _FakeBiometricService extends BiometricService {
  @override
  Future<bool> authenticate() async => true;
}

void main() {
  testWidgets('Successful auth navigates to /vault_list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/login': (_) => LoginScreen(biometricService: _FakeBiometricService()),
          '/vault_list': (_) => const VaultListScreen(),
        },
        initialRoute: '/login',
      ),
    );

    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.text('Authenticate'));
    await tester.pumpAndSettle();

    expect(find.text('Vault Items'), findsOneWidget);
  });
}
