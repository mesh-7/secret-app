import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/ui/screens/login_screen.dart';
import 'package:secure_vault/ui/screens/vault_list_screen.dart';
import 'package:secure_vault/ui/screens/item_detail_screen.dart';
import 'package:secure_vault/ui/screens/settings_screen.dart';

void main() {
  testWidgets('LoginScreen renders', (tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('VaultListScreen renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: VaultListScreen()));
    expect(find.text('Vault Items'), findsOneWidget);
  });

  testWidgets('ItemDetailScreen renders id', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ItemDetailScreen(id: '99')));
    expect(find.text('Item 99'), findsOneWidget);
  });

  testWidgets('SettingsScreen renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    expect(find.text('Settings'), findsOneWidget);
  });
}
