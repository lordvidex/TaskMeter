import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_meter/core/errors.dart';
import '../../domain/models/settings.dart';
import '../../domain/models/task_group.dart';

abstract class RemoteStorage {
  //! Authentication section
  Future<User> signinUserWithEmail(String email, String password);
  Future<User> signupUserWithEmail(String email, String password);

  //! Settings section
  /// Fetches the saved settings from Firebase
  /// Returns `null` if user does not have saved data
  Future<Settings> fetchSettings();

  /// Update settings in the remote database
  Future<void> updateSettings(Settings newSettings);

  //! Task Groups section
  /// fetches the List of taskGroups from firebase and returns `null` if user
  /// either not logged in or does not have any data saved
  Future<List<TaskGroup>> fetchTaskGroups();

  /// updates taskGroups in the database
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups);
}

class RemoteStorageImpl implements RemoteStorage {
  final FirebaseAuth _firebaseAuth;

  const RemoteStorageImpl({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  Future<Settings> fetchSettings() {
    // TODO: implement fetchSettings
    return null;
  }

  @override
  Future<List<TaskGroup>> fetchTaskGroups() {
    // TODO: implement fetchTaskGroups
    return null;
  }

  @override
  Future<void> updateSettings(Settings newSettings) {
    // TODO: implement updateSettings
  }

  @override
  Future<void> updateTaskGroups(List<TaskGroup> taskGroups) {
    // TODO: implement updateTaskGroups
  }

  @override
  Future<User> signinUserWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserDoesNotExistException();
        case 'wrong-password':
        case 'invalid-email':
          throw WrongCredentialsException();
        default:
          throw ServerException();
      }
    }
  }

  @override
  Future<User> signupUserWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw UserExistsException();
        default:
          throw ServerException();
      }
    }
  }
}
