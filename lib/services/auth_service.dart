import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream para o estado de autenticação do usuário
  Stream<User?> get user => _auth.authStateChanges();

  // Obter o usuário atual
  User? get currentUser => _auth.currentUser;

  // Cadastro com E-mail e Senha
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login com E-mail e Senha
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
       notifyListeners();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}