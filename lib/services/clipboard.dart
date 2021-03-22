// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:zimster_messaging/app/base_model.dart';
// import 'package:zimster_messaging/app/service_locator.dart';
// import 'package:zimster_messaging/models/appuser-model.dart';
// import 'package:zimster_messaging/models/message_model.dart';
// import 'package:zimster_messaging/services/authentication_service.dart';
// import 'package:zimster_messaging/services/chat_service.dart';
// import 'package:zimster_messaging/services/firestore_service.dart';

// class ChatGroupsViewModel extends BaseModel {
//   AuthenticationService authenticationService =
//       serviceLocator<AuthenticationService>();
//   FirestoreService firestoreService = serviceLocator<FirestoreService>();
//   ChatService chatService = serviceLocator<ChatService>();
//   String chatGroupId;
//   AppUserModel get currentAppUser => authenticationService.currentAppUser;

// //   void initModel() {}
//   Stream<QuerySnapshot> userChatGroups;
//   Stream<QuerySnapshot> chatGroupMessages;

// // //TODO functions for

//   getUserChatGroups() => userChatGroups = chatService.getUserChatGroups();

//   Stream<QuerySnapshot> getChatGroupMessages({String chatGroupId}) =>
//       chatGroupMessages = ChatService.getMessages(chatGroupId: chatGroupId);
//   Stream<QuerySnapshot> getNothing() => chatGroupMessages = ChatService.getMessages(chatGroupId: chatGroupId);

// ()
//   getChatGroupDoc({String chatGroupId}) => chatService.getChatGroupDoc();

  

//   getChatGroupUnreadCount() {}
//   getChatGroupMemebers() {}
//   // getContacts() {}

//   // newContact() {}
//   // updateContact() {}

//   // getGroupMessages({String groupId}) =>
//   //     ChatService.getMessages(groupId: groupId);

// }
