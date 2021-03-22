import 'package:zimster_messaging/app/base_model.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/appuser-model.dart';
import 'package:zimster_messaging/models/message_model.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/chat_service.dart';
import 'package:zimster_messaging/services/firestore_service.dart';

class ChatGroupsViewModel extends BaseModel {
  AuthenticationService authenticationService =
      serviceLocator<AuthenticationService>();
  FirestoreService firestoreService = serviceLocator<FirestoreService>();
  ChatService chatService = serviceLocator<ChatService>();

  final String groupId;

  ChatGroupsViewModel({this.groupId});
///////////////////////////////////////////////
  AppUserModel get currentAppUser => authenticationService.currentAppUser;

//   void initModel() {
// //TODO functions for
//     // getContacts() {}
//     // newContact() {}
//     // updateContact() {}

  //  getGroupMessages({ String groupId})  =>
  //     ChatService.getMessages( groupId: );

}
