import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/src/features/auth/models/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      final String uid = _firebaseAuth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to save user to Firestore');
    }
  }

  Future<void> saveUserLocally(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
  }

  Future<UserModel?> getUserFromFirestore(String uid) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Failed to get user from Firestore');
    }
    return null;
  }

  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        final newUser = UserModel(
            email: user.email!, password: password, fullName: fullName);
        await saveUserToFirestore(newUser);
        await saveUserLocally(newUser);
        return newUser;
      }
    } catch (e) {
      throw Exception('Failed to sign up');
    }
    return null;
  }

  Future<UserModel?> logInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        final loggedInUser = await getUserFromFirestore(user.uid);
        await saveUserLocally(loggedInUser!);
        return loggedInUser;
      }
    } catch (e) {
      throw Exception('Failed to log in');
    }
    return null;
  }

  Future<void> clearUserLocally() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user'); // Adjust key as necessary
  }
}
