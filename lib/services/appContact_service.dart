import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/appContact_model.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/services/dialog_service.dart';
import 'package:zimster_messaging/services/firestore_service.dart';
import 'package:zimster_messaging/app/constants.dart' as constants;

// # region Legal

/// Copyright 2017 The EnigmaTek.Inc. All rights reserved.
/// Use of this source code is governed by a BSD-style license that can be
/// found in the LICENSE file.
/// endregion

// # region imports
import '../app/route_paths.dart' as routes;
import 'navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/appuser-model.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:contacts_service/contacts_service.dart';

// endregion

/// # region ClassInfo
final String className = 'AuthenticationService';
final String _version = '1.0.0';
final String _packageName = 'zimster_messaging';

/// endregion

class AppContactService {
// final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final DialogService _dialogService = serviceLocator<DialogService>();
  final FirestoreService _firestoreService = serviceLocator<FirestoreService>();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();
  List<Contact> deviceContacts, appContacts;

  loadDeviceContacts() async {
    ConsoleUtility.printToConsole('starting to read device contacts');
    deviceContacts = (await ContactsService.getContacts(
            withThumbnails: false, orderByGivenName: true))
        .toList();
        
    ConsoleUtility.printToConsole('finished reading  device contacts');
    ConsoleUtility.printToConsole(
        ' ${deviceContacts.length.toString()} DEVICE CONTACTS  found \n ....scanning for ones present on Zimster....');
    for (var contact in deviceContacts) {
      // ConsoleUtility.printToConsole(
      //     'searching for ...${contact.displayName}... in Zimster Users');
      List<String> _phones = [];
      for (var item in contact.phones) {
        _phones.add(item.value);
        for (var phone in _phones) {
          await getAppContactbyId(
              userId: phone, displayName: contact.displayName);
        }
      }
    }
  }

  Future getAppContactbyId({String userId, String displayName}) async {
    _firestoreService
        .getAppUserbyId(userId: userId)
        .then((value) => handleAppContac);
  }

  dynamic handleAppContac(AppContactModel appContactModel) {}

  // getDeviceContactByPhone({String phone}) async {
  //   var searchContact =
  //       (await ContactsService.getContactsForPhone(phone)).toList();
  //   ConsoleUtility.printToConsole(
  //       'matching contacts = ${searchContact.length.toString()}\n searched contact = ${searchContact[0].displayName}');
  //   return searchContact;
  // }

}
