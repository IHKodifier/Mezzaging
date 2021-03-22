import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zimster_messaging/app/constants.dart' as constants;
// import 'package:firebase/firestore.dart';
import 'package:zimster_messaging/app/route_paths.dart' as routes;
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/chatGroup_model.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/chat_service.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/ui/shared/user_avatar.dart';
import '../../../services/firestore_service.dart';

class ChatGroupTile extends StatelessWidget {
  ChatGroupModel chatGroupModel;
  // final Map<String, dynamic> userChatGroupData;
  final String userId;
  // String groupId;
  bool isMe;
  // bool isGroup = false;
  // String chatTitle = '';
  // List<dynamic> members;
  // String chatPartner;
  DocumentSnapshot chatPartnerAppUserDoc;

  ///temporarily called firestore instance directly
  /////TODO
  /////implement view model.
  final FirestoreService db = serviceLocator<FirestoreService>();
  final AuthenticationService authservice =
      serviceLocator<AuthenticationService>();
  final ChatService chatService = serviceLocator<ChatService>();

  ChatGroupTile({Key key, this.userId,
  this.chatGroupModel})
      : super(key: key);

  Widget build(BuildContext context) {
    // chatTitle = chatService.getChatGroup(
    // //     chatGroupDoc: userChatGroupData, userId: userId)['title'];
    // // getChatPartnerUserDoc();
    // var chatPartnerDoc;
    // if (userChatGroupData['isGroup']) {
    //   // chatTitle = userChatGroupData['name'];
    // }
    //  =  chatService.getChatPartnerDoc();

    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed(routes.ConversationViewRoute, arguments: groupId);
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: UserAvatarWidget(
              // photoURL: chatPartnerDoc.data()['photoURL'],
              ),
          title: Text(
            '',
            overflow: TextOverflow.ellipsis,
          ),
          // trailing: Text(data['recentMessage[sentAt]']),
        ),
      ),
    );
  }
  // void _navigate()
}
