import 'package:contacts_service/contacts_service.dart';
import 'package:zimster_messaging/app/base_model.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/appuser-model.dart';
import 'package:zimster_messaging/services/appContact_service.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/dialog_service.dart';
import 'package:zimster_messaging/services/navigation_service.dart';

// import '../../../services/console_utility.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../../../app/route_paths.dart' as routes;
// import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel extends BaseModel {
  AuthenticationService _authService = serviceLocator<AuthenticationService>();
  AuthenticationService get authService => _authService;
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  AppContactService appContactService = serviceLocator<AppContactService>();

  void signOut() {
    _authService.signout();
    _navigationService.popAndPush(routes.LoginRoute);
  }

  Future readContacts() async {
    appContactService.loadDeviceContacts();
  }

  AppUserModel get currentAppUser => authService.currentAppUser;
  void navigateToAppContactsListView() {
    _navigationService.navigateTo(routes.AppContactsListView);
  }
}
