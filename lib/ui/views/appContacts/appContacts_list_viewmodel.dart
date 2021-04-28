import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimster_messaging/app/base_model.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/services/appContact_service.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/services/dialog_service.dart';
import 'package:zimster_messaging/services/firestore_service.dart';
import 'package:zimster_messaging/services/navigation_service.dart';
import '../../../app/route_paths.dart' as routes;
import '../../../services/console_utility.dart' as console;

class AppContactsListViewModel extends StreamViewModel<QuerySnapshot> {
  // final
  //all services needed
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  FirestoreService firestoreService = serviceLocator<FirestoreService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  AppContactService _appContactService = serviceLocator<AppContactService>();

  @override
  // TODO: implement isBusy
  bool get isBusy => super.isBusy;

  @override
  // TODO: implement stream
  Stream<QuerySnapshot> get stream => _appContactService.streamCloudContacts();

  searchContact() {
    ConsoleUtility.printToConsole('searching in  contacts.....');
  }

  refreshContacts() {
    ConsoleUtility.printToConsole('refreshing contacts.....');
  }

  newContact() async {
    ConsoleUtility.printToConsole('create NEW  contact.....');
  
    Contact contact =
        await ContactsService.openContactForm(iOSLocalizedLabels: true);
    ContactsService.addContact(contact);


    ConsoleUtility.printToConsole(contact.displayName);

    // <Map<String,dynamic>phoneNumers=contact.phones.toList();
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('appUsers')
        .doc(_authenticationService.currentAppUser.userId)
        .collection('appContacts')
        .doc();
    Map<String, dynamic> contactAsMap = {
      'userId': contact.displayName,
    };

    await documentReference.set(contactAsMap).then((value) =>
        ConsoleUtility.printToConsole('new Contact created at Firebase'));
  }
}
