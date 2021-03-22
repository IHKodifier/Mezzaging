import 'package:contacts_service/contacts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:zimster_messaging/app/base_model.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/services/appContact_service.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/dialog_service.dart';
import 'package:zimster_messaging/services/navigation_service.dart';
import '../../../app/route_paths.dart' as routes;
import '../../../services/console_utility.dart' as console;

class AppContactsListViewModel extends BaseViewModel {
  // final
  //all services neserveded
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  AppContactService _appContactService = serviceLocator<AppContactService>();
  List<Contact> deviceContacts, appContacts;

  Future initializeModel() async {
    //  TODO: check permissions
    setBusy(true);
    // await _appContactService.loadDeviceContacts();
     deviceContacts = await _appContactService.deviceContacts;
    appContacts = await _appContactService.appContacts;
    setBusy(false);
  }

  @override
  // TODO: implement isBusy
  bool get isBusy => super.isBusy;
}
