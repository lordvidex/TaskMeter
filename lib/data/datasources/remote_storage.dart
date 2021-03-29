import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Settings;
import '../../core/errors.dart';
import 'local_storage.dart';
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

  /// fetches the time to the last update to the local database
  Future<DateTime> getLastTaskGroupUpdateTime();

  /// deletes a taskGroup from the remoteStorage
  Future<void> deleteTaskGroup(String id, DateTime timeOfUpdate);

  /// updates taskGroups in the database
  Future<void> updateTaskGroups(
      List<TaskGroup> taskGroups, DateTime timeOfUpdate);
}

class RemoteStorageImpl implements RemoteStorage {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  const RemoteStorageImpl(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  DocumentReference get _userDocument =>
      _firestore?.collection('users')?.doc(_firebaseAuth.currentUser.uid);
  DocumentReference get _settingsDocument =>
      _userDocument.collection('Settings').doc(SETTINGS);
  CollectionReference get _taskGroupDocument =>
      _userDocument.collection(TASKGROUPS);
  DocumentReference get _taskGroupTimeDocument =>
      _userDocument.collection('last_update_time').doc(TIME_OF_UPLOAD);

  @override
  Future<Settings> fetchSettings() async {
    if (_firebaseAuth.currentUser == null || _userDocument == null) {
      return null;
    }
    try {
      final data = await _settingsDocument.get();
      return Settings.fromJson(data.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<TaskGroup>> fetchTaskGroups() async {
    if (_firebaseAuth.currentUser == null || _userDocument == null) {
      return null;
    }
    final snapshot = await _taskGroupDocument.get();
    return snapshot.docs
        .map((data) => TaskGroup.fromJson(data.data()))
        .toList();
  }

  @override
  Future<void> updateSettings(Settings newSettings) async {
    if (_firebaseAuth.currentUser == null || _userDocument == null) {
      return null;
    }
    await _settingsDocument.set(newSettings.toJson());
  }

  @override
  Future<void> updateTaskGroups(
      List<TaskGroup> taskGroups, DateTime timeOfUpdate) async {
    if (_firebaseAuth.currentUser == null || _userDocument == null) {
      return null;
    }
    taskGroups.forEach(
        (tg) => _taskGroupDocument.doc(tg.taskGroupId).set(tg.toJson()));
    await setLastTaskGroupUpdateTime(timeOfUpdate);
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

  @override
  Future<DateTime> getLastTaskGroupUpdateTime() async {
    final doc = await _taskGroupTimeDocument.get();
    if (doc.exists) {
      return DateTime.tryParse(doc.get(TIME_OF_UPLOAD) as String);
    }
    return null;
  }

  Future<void> setLastTaskGroupUpdateTime(DateTime timeOfUpdate) async {
    await _taskGroupTimeDocument
        .set({TIME_OF_UPLOAD: timeOfUpdate.toIso8601String()});
  }
  @override
  Future<void> deleteTaskGroup(String id, DateTime timeOfUpdate) async {
    await _taskGroupDocument.doc(id).delete();
  }
}
