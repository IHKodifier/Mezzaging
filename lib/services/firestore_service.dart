/// # region imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimster_messaging/models/appContact_model.dart';
import '../app/service_locator.dart';
import '../models/appuser-model.dart';
import '../services/console_utility.dart';
import '../services/dialog_service.dart';

/// endregion

/// # region ClassInfo
final String className = 'FirestoreService';
final String _version = '1.0.0';
final String _packageName = 'zimster_messaging';

/// endregion

/// this class wraps all the functionality required by an App to write/retrive update documents to firestore database
/// Singleton instance of this class is available across the  App  and get can be refernced by
/// instantiating an [[AuthenticationService]] via call to serviceLocator. syntax below
/// /// final AuthenticationService _authService =serviceLocator<AuthenticationService>();
///
///

class FirestoreService {
  final DialogService dialogService = serviceLocator<DialogService>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference _usercollectionReference =
      FirebaseFirestore.instance.collection('appUsers');

  Future<bool> createAppUserDoc(
      {AppUserModel appUser, bool merge = true}) async {
    try {
      await _usercollectionReference.doc(appUser.email).set(appUser.toJson());
      ConsoleUtility.printToConsole(
          'created Appuser in Firestore\n${appUser.toJson().toString()}');
    } catch (e) {
      ConsoleUtility.printToConsole(
          'Firestore service\n createUserProfile\nerror encountered: \n${e.toString()}');
      dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    }
  }

  Future<bool> createAppUserDocforPhoneSignup({
    AppUserModel appUser,
    bool merge = true,
    String phoneNumber,
  }) async {
    try {
      await _usercollectionReference.doc(phoneNumber).set(appUser.toJson());
      ConsoleUtility.printToConsole(
          'created Appuser in Firestore\n${appUser.toJson().toString()}');
    } catch (e) {
      ConsoleUtility.printToConsole(
          'Firestore service\n createUserProfile\nerror encountered: \n${e.toString()}');
      dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    }
  }

  static Stream<List<AppUserModel>> getUsers() => FirebaseFirestore.instance
      .collection('/appUsers')
      .orderBy(AppUserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(ConsoleUtility.transformer(AppUserModel.fromJson));

  Future<AppContactModel> getAppUserbyId(
      {String userId, String displayName}) async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('appUsers')
        .where('uid', isEqualTo: userId)
        .get();
    if (querySnapshot.docs.length != 0) {
      // ConsoleUtility.printToConsole(
      //     '${displayName}--- ${userId} has been found on Zimter');
      // print(querySnapshot.docs[0].data());
    } else {}
    // ConsoleUtility.printToConsole(
    //     '${displayName}--- ${userId}\n NOT \n found on Zimter\n continuing search...');
  }

  Future<QuerySnapshot> hasCloudContacts({String userId}) async {
    final value = await firebaseFirestore
        .collection('appUsers')
        .doc(userId)
        .collection('appContacts')
        .get();
    ConsoleUtility.printToConsole(
        '${value.docs.length} app contacts found for current user');
  }
}
