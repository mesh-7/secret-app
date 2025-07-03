import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/services/biometric_service.dart';

/// A fake implementation that bypasses platform channels.
class _FakeBiometricService extends BiometricService {
  @override
  Future<bool> authenticate() async => true;
}

void main() {
  test('BiometricService can be subclassed and called', () async {
    final svc = _FakeBiometricService();
    final ok = await svc.authenticate();
    expect(ok, isTrue);
  });
}
