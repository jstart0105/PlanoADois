import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await canAuthenticate()) return false;

      return await _auth.authenticate(
        localizedReason: 'Faça login para continuar',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Erro na autenticação biométrica: $e');
      return false;
    }
  }
}