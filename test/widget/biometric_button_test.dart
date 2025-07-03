import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/ui/widgets/biometric_button.dart';

void main() {
  testWidgets('BiometricButton invokes onTap callback', (tester) async {
    int tapped = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BiometricButton(
            onTap: () => tapped++,
            label: 'Tap me',
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap me'));
    await tester.pump();

    expect(tapped, 1);
  });
}
