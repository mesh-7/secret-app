import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/ui/widgets/encrypted_text_field.dart';

void main() {
  testWidgets('Toggling reveal icon switches visibility state', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EncryptedTextField(hintText: 'Secret'),
        ),
      ),
    );

    // Initially should show the "visibility" icon (obscured state).
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsNothing);

    // Tap the icon to toggle visibility.
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();

    // Icon should switch to visibility_off.
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });
}
