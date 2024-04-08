import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shoes_app/model/user.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  factory FirebaseService() {
    return _instance;
  }

  // Named Constructor
  FirebaseService._internal();

  /***************************Firebase Authentication ***************************************/

  Future<void> signInWithEmailPassword(
      {required String email,
        required String password,
        required Function(UserCredential) onSuccess,
        required Function(String) onError}) async {
    try {
      UserCredential credential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      onSuccess(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
  Future<dynamic> signup(String email, String password) async {
    String errorText = '';

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential != null) {
        return credential;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorText = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorText = 'The account already exists for that email.';
      }
    } catch (e) {
      errorText = e.toString();
    }
    return errorText;
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  /***************************Firebase Realtime Database ***************************************/

  DatabaseReference databaseRef =
  FirebaseDatabase.instance.ref(); // contains root path

  Future<bool> createUser(UserData user) async {
    try {
      await databaseRef.child('users').child(user.id!).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<UserData?> getUserData(String userId) async {
    try {
      DataSnapshot dataSnapshot = await _databaseRef.child('users').child(userId).once() as DataSnapshot;

      if (dataSnapshot.value != null) {
        Map<String, dynamic> userDataMap = dataSnapshot.value as Map<String, dynamic>;
        UserData userData = UserData.fromMap(userDataMap);
        return userData;
      } else {
        // User data not found
        return null;
      }
    } catch (e) {
      // Error occurred while fetching user data
      print("Error fetching user data: $e");
      return null;
    }
  }
}
