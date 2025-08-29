import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // change password;
  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('მომხმარებელი არ არის ავტორიზებული.');
    }
    await user.updatePassword(newPassword);
  }

  // Update phone number
  Future<void> updatePhoneNumber(String phoneNumber) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('მომხმარებელი არ არის ავტორიზებული.');
    }
    await _firestore.collection('users').doc(user.uid).update({
      'phoneNumber': phoneNumber.trim(),
    });
  }

  // Update Profile Image (store as Base64 string in Firestore)
  Future<void> updateProfileImage(Uint8List imageBytes) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw Exception('მომხმარებელი არ არის ავტორიზებული.');
    }

    final base64Image = base64Encode(imageBytes);
    await _firestore.collection('users').doc(uid).update({
      'profileImage': base64Image,
    });
  }

  Future<UserCredential> registerWithEmail(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      // create user in Authservice
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // create user in Firestore
      final uid = userCredential.user!.uid;
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email.trim(),
        'fullName': fullName.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      return userCredential;
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
