import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Service class that handles all authentication-related operations
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Stream that emits the current user when authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Signs in a user with email and password
  /// 
  /// Throws [FirebaseAuthException] if sign-in fails
  Future<UserCredential> signInWithEmailAndPassword({
    required String email, 
    required String password
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Registers a new user with email and password
  ///
  /// Throws [FirebaseAuthException] if registration fails
  Future<UserCredential> registerWithEmailAndPassword({
    required String email, 
    required String password
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Signs in a user with Google authentication
  ///
  /// Returns null if user cancels the sign-in process
  /// Throws [FirebaseAuthException] if sign-in fails
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Create Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with credential
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  /// Signs out the current user from both Firebase and Google
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  /// Sends a password reset email to the specified email address
  ///
  /// Throws [FirebaseAuthException] if operation fails
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Permanently deletes the current user's account
  ///
  /// Throws [FirebaseAuthException] if operation fails
  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Returns the current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Handles Firebase auth exceptions and provides user-friendly messages
  FirebaseAuthException _handleAuthError(FirebaseAuthException e) {
    String message;
    
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is badly formatted.';
        break;
      case 'user-disabled':
        message = 'This account has been disabled.';
        break;
      case 'user-not-found':
        message = 'No account found with this email.';
        break;
      case 'wrong-password':
        message = 'Incorrect password. Please try again.';
        break;
      case 'email-already-in-use':
        message = 'An account already exists with this email.';
        break;
      case 'operation-not-allowed':
        message = 'Email/password accounts are not enabled.';
        break;
      case 'weak-password':
        message = 'The password is too weak.';
        break;
      case 'requires-recent-login':
        message = 'Please sign in again to perform this operation.';
        break;
      default:
        message = 'An unexpected error occurred. Please try again.';
    }

    return FirebaseAuthException(
      code: e.code,
      message: message,
      email: e.email,
      credential: e.credential,
    );
  }
}