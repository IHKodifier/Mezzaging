import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/appuser-model.dart';
import 'package:zimster_messaging/models/chatGroup_model.dart';
import 'package:zimster_messaging/models/message_model.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/services/dialog_service.dart';

class ChatService {
  final DialogService dialogService = serviceLocator<DialogService>();
  final AuthenticationService authenticationService =
      serviceLocator<AuthenticationService>();

  // ignore: unused_field
  final db = FirebaseFirestore.instance;
  String chatGroupId;

  static Future uploadMessage({
    String userId,
    String chatGroupId,
    String message,
  }) async {
    final refMessages =
        // ignore: unnecessary_brace_in_string_interps
        FirebaseFirestore.instance.collection('message/${chatGroupId}/messages');

    final newMessage = MessageModel(
      userId: userId,
      //set it to currentAuthenticated user
      photoURL: 'abc',
      //  myUrlAvatar,
      username: userId,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());
  }

  static Stream<QuerySnapshot> getMessages({String chatGroupId}) =>
      FirebaseFirestore.instance
          .collection('message/$chatGroupId/messages')
          .orderBy(AppUserField.lastMessageTime, descending: true)
          .snapshots();

  Stream<QuerySnapshot> getUserChatGroups() => db
      .collection('chatGroups')
      .where('members',
          arrayContains: authenticationService.currentAppUser.userId)
      // .orderBy(AppUserField.lastMessageTime, descending: true)
      .snapshots();

  DocumentSnapshot chatPartnerDoc;
  Future<DocumentSnapshot> getChatPartnerDoc() async {
    // chatPartnerDoc = await db.collection('appUsers').doc(chatPartner).get();
    return chatPartnerDoc;
  }

  Future<DocumentSnapshot> getChatGroupDoc({String chatGroupId}) async {
    return await db.collection('chatGroups').doc(chatGroupId).get();
  }

  // String getChatGroupTitle({
  //   Map<String, dynamic> chatGroupDoc,
  //   String userId,
  // }) {
  //   List<dynamic> members = chatGroupDoc['members'];
  //   String chatPartner;
  //   if (chatGroupDoc['isGroup']) {
  //     return chatGroupDoc['name'];
  //   } else {
  //     if (members.first == userId) {
  //       ///chat partner is the other guy in [members] list
  //       chatPartner = members.last;
  //       return members.last;
  //     } else {
  //       ///chat partner is this guy
  //       chatPartner = members.first;
  //       return members.first;
  //     }
  //   }
  //   // getChatPartnerDoc();
  // }

  ChatGroupModel getChatGroup({
    Map<String, dynamic> chatGroupDoc,
    String userId,
  }) {
    ChatGroupModel chatGroupModel = ChatGroupModel.fromMap(chatGroupDoc);

    List<dynamic> members = chatGroupDoc['members'];

    if (!chatGroupModel.isGroup) {
      if (members.first == userId) {
        //chat partner is the other guy in [members] list
        //set the [chatgroupt Title] to otherguy userId
        chatGroupModel.title = members.last;
        //TODO: set Adress Book based names

      } else {
        ///chat partner is this guy
        chatGroupModel.title = members.first;
      }
    }
    return chatGroupModel;
  }
}
