import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LogInWithPhoneNumberFailure implements Exception {
  const LogInWithPhoneNumberFailure([
    this.message = 'Terjadi kesalahan',
  ]);
  final String message;

  factory LogInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-verification-code':
        return const LogInWithPhoneNumberFailure(
          'Kode verifikasi tidak valid.',
        );
      default:
        return const LogInWithPhoneNumberFailure();
    }
  }
}

class SendEmailVerificationFailure implements Exception {
  const SendEmailVerificationFailure([
    this.message = 'terjadi kesalahan',
  ]);

  final String message;
}

class LinkWithEmailAndPasswordFailure implements Exception {
  const LinkWithEmailAndPasswordFailure([
    this.message = 'Terjadi kesalahan',
  ]);
  final String message;

  factory LinkWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case "provider-already-linked":
        return LinkWithEmailAndPasswordFailure(
            "The provider has already been linked to the user.");
      case "invalid-credential":
        return LinkWithEmailAndPasswordFailure(
            "The provider's credential is not valid.");
      case "credential-already-in-use":
        return LinkWithEmailAndPasswordFailure(
            "The account corresponding to the credential already exists, "
            "or is already linked to a Firebase User.");
      default:
        return LinkWithEmailAndPasswordFailure();
    }
  }
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'Terjadi kesalahan.',
  ]);

  final String message;

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email tidak valid.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'Email sudah digunakan',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Kata sandi kurang kuat.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    firebase_firestore.FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore =
            firebaseFirestore ?? firebase_firestore.FirebaseFirestore.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final firebase_firestore.FirebaseFirestore _firebaseFirestore;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      return firebaseUser == null
          ? User.empty
          : firebaseUserToUser(firebaseUser);
    });
  }

  User firebaseUserToUser(firebase_auth.User? firebaseUser) {
    final Map<String, dynamic> data = {};
    if (firebaseUser != null) {
      data['id'] = firebaseUser.uid;
      data['name'] = firebaseUser.displayName;
      data['email'] = firebaseUser.email;
      data['phoneNumber'] = firebaseUser.phoneNumber;
      data['photoURL'] = firebaseUser.photoURL;
      data['emailVerified'] = firebaseUser.emailVerified;
      return User.fromMap(data);
    }
    return User.empty;
  }

  User get currentUser {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return firebaseUserToUser(firebaseUser);
    }
    return User.empty;
  }

  Stream<User> userData({required String id}) {
    return _firebaseFirestore
        .collection('users')
        .doc(id)
        .snapshots()
        .map((doc) {
      final data = doc.data()!;
      data['id'] = doc.id;
      data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;

      return User.fromMap(data);
    });
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function(String message) verificationFailed,
    int? resendToken,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (firebase_auth.PhoneAuthCredential credential) {},
      verificationFailed: (firebase_auth.FirebaseAuthException e) {
        switch (e.code) {
          case 'invalid-phone-number':
            verificationFailed("nomor telepon tidak valid");
          case 'too-many-requests':
            verificationFailed("terlalu banyak permintaan");
          case 'internal-error':
            verificationFailed("kesalahan internal");
          default:
            verificationFailed("Terjadi kesalahan");
        }
      },
      forceResendingToken: resendToken,
      codeSent: (String verificationId, int? resendToken) async {
        codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> insertUserToFirestore() async {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      final Map<String, dynamic> data =
          firebaseUserToUser(_firebaseAuth.currentUser!).toMap();
      final String id = data['id'];
      data.remove("id");
      await _firebaseFirestore.collection('users').doc(id).set(data);
    }
  }

  Future<void> LogInWithPhoneNumber({
    required verificationId,
    required smsCode,
  }) async {
    try {
      firebase_auth.PhoneAuthCredential credential =
          firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
      await insertUserToFirestore();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithPhoneNumberFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser!;
    try {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (_) {
      throw SendEmailVerificationFailure();
    }
  }

  Future<void> linkEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = firebase_auth.EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    try {
      await _firebaseAuth.currentUser?.linkWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LinkWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw LinkWithEmailAndPasswordFailure();
    }
  }

  Future<void> updateProfile({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await _firebaseFirestore.collection('users').doc(id).update(data);
    if (data['name'] != null) {
      await _firebaseAuth.currentUser!.updateDisplayName(data['name']);
    }
    if (data['phoneNumber'] != null) {
      await _firebaseAuth.currentUser!.updatePhoneNumber(data['phoneNumber']);
    }
    if (data['photoURL'] != null) {
      await _firebaseAuth.currentUser!.updatePhotoURL(data['photoURL']);
    }
  }
}
