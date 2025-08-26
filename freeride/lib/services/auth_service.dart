import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  final _auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserCredential> loginWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> signOut() async => _auth.signOut();

  Exception _mapError(FirebaseAuthException e) {
    // Friendly messages (Georgian)
    final code = e.code;
    String message;
    switch (code) {
      case 'invalid-email':
        message = 'ელ-ფოსტა არ არის ვალიდური.';
        break;
      case 'email-already-in-use':
        message = 'ეს ელ-ფოსტა უკვე რეგისტრირებულია.';
        break;
      case 'weak-password':
        message = 'გთხოვთ, გამოიყენოთ უფრო ძლიერი პაროლი.';
        break;
      case 'user-not-found':
        message = 'მომხმარებელი ვერ მოიძებნა.';
        break;
      case 'wrong-password':
        message = 'პაროლი არასწორია.';
        break;
      case 'too-many-requests':
        message = 'ძალიან ბევრი მცდელობა. სცადეთ მოგვიანებით.';
        break;
      default:
        message = 'დაფიქსირდა შეცდომა: ${e.message ?? code}';
    }
    return Exception(message);
  }
}
