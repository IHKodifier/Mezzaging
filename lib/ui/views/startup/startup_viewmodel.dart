import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zimster_messaging/models/appuser-model.dart';
import '../../../app/service_locator.dart';
import '../../../app/route_paths.dart';
import '../../../services/authentication_service.dart';
import '../../../services/console_utility.dart';
import '../../../services/dialog_service.dart';
import '../../../services/navigation_service.dart';
import 'package:stacked/stacked.dart';
import '../welcome/welcome_view.dart';
import 'package:stacked/stacked.dart';
import '../../../app/route_paths.dart' as routes;
import 'package:device_info/device_info.dart';

class StartupViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  DialogService _dialogService = serviceLocator<DialogService>();

  void signOut() {
    _authenticationService.signout();
    _navigationService.navigateTo(routes.LoginRoute);
  }

  Future showDialog() async {
    ConsoleUtility.printToConsole('dialog called');
    var dialogResult = await _dialogService.showDialog(
      title: 'Loggin Successfull',
      description: 'FilledStacks architecture rocks',
    );
    if (dialogResult.confirmed) {
      ConsoleUtility.printToConsole('User has confirmed');
    } else {
      ConsoleUtility.printToConsole('User cancelled the dialog');
    }
  }

  Future resolveStartupLogin() async {
    setBusy(true);
    ConsoleUtility.printDeviceInfo();
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    if (hasLoggedInUser) {
      //  await  _authenticationService.setAuthenticatedUserFromFirestore();
      String id = _authenticationService.authInstance.currentUser.email;

      DocumentSnapshot documentSnapshot = await _authenticationService.getAppUserDocById(id);
      // _authenticationService.currentAppUser =
      //     _authenticationService.authInstance.currentUser as AppUser;
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(WelcomeRoute);
    }
    setBusy(false);
  }

  String _title = 'Startup View Model Widget';
  String get title => _title;
}
