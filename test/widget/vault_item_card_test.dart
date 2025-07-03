import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/ui/widgets/vault_item_card.dart';

void main() {
  testWidgets('VaultItemCard renders given title', (tester) async {
    const title = 'My Secret';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: VaultItemCard(title: title),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
  });
}
