import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zimster_messaging/services/appContact_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/console_utility.dart';
import '../../../services/dialog_service.dart';
import '../../../services/navigation_service.dart';
import '../../../app/service_locator.dart';
import '../../../app/base_model.dart';
import '../../../app/route_paths.dart' as routes;
// import '../login/login_view.dart';

class AppContactViewModel extends BaseModel {
  // final 
  //all services needed
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  AppContactService _appContactService = serviceLocator<AppContactService>();
  List<Contact> deviceContacts, appContacts;

  // Future<void> initModel() async {
  //   // await _appContactService.loadDeviceContacts();
  //   // deviceContacts = _appContactService.deviceContacts;
  //   appContacts = _appContactService.appContacts;
  // }

  ContactsService _contactsService = ContactsService();
  // _contactsService.
}
