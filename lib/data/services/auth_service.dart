import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServiceInterface {
  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}

class AuthService implements AuthServiceInterface {
  AuthService();

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Не удалось зарегистрироваться');
    } catch (_) {
      throw Exception('Неизвестная ошибка регистрации');
    }
  }

  @override
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Не удалось войти');
    } catch (_) {
      throw Exception('Неизвестная ошибка входа');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Не удалось выйти из аккаунта');
    } catch (_) {
      throw Exception('Неизвестная ошибка выхода из аккаунта');
    }
  }

}
