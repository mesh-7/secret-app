import 'package:local_auth/local_auth.dart';

/// Biometric authentication service using `local_auth`.
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Prompts the user for biometric authentication.
  /// Returns `true` if successful, otherwise `false`.
  Future<bool> authenticate() async {
    try {
      final bool canCheck = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
      if (!canCheck) return false;

      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to access SecureVault',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (_) {
      // Any platform-specific errors (e.g., no biometrics enrolled) fall back to false.
      return false;
    }
  }
}
