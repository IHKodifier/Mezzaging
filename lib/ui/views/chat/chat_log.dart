import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zimster_messaging/models/appuser-model.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/message_model.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/chat_service.dart';
// import'../';
import 'package:zimster_messaging/ui/views/chat/chatGroups_viemodel.dart';
import 'package:zimster_messaging/ui/views/chat/chatGroups_viewmodel.dart';
import 'package:zimster_messaging/ui/views/chat/messageWidget.dart';
import 'package:zimster_messaging/ui/views/chat/newMessage.dart';
import 'package:stacked/stacked.dart';

class ChatLogWidget extends StatelessWidget {
  final AppUserModel appUser = AuthenticationService().currentAppUser;
  final ChatService chatService = serviceLocator<ChatService>();
  // <ChatService>();
  final chatGroupId;

  ChatLogWidget({Key key, this.chatGroupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatGroupViewModel>.reactive(
      viewModelBuilder: () => ChatGroupViewModel(chatGroupId: chatGroupId),
      builder: (context, model, child) => Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   height: 60,
              //   child: CircleAvatar(
              //     radius: 20,
              //     child: Image.network(constants.kPhotoURLIfBlank))),
              Text(chatGroupId),
            ],
          ),
        ),
        // backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              // ConversationHeaderWidget(name: model.currentAppUser.displayName),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  //

                  child: StreamBuilder(
                      stream: model.getChatGroupMessages(chatGroupId: chatGroupId),
                      // stream: model.g
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return buildMessage( model, snapshot);
                        } else
                          return Center(child: CircularProgressIndicator());
                       
                      }
                      ),
                ),
              ),
              NewMessageWidget(
                  idUser: model.currentAppUser.userId, groupId: chatGroupId)
            ],
          ),
        ),
      ),
    );
  }

  QuerySnapshot querySnapshot;
  bool isMe;
  Widget buildMessage(ChatGroupViewModel model, dynamic snapshot) {
    // this.querySnapshot = snapshot;
    return ListView.builder(
      itemCount: snapshot.userChatGroupData.docs.length,
      itemBuilder: (context, index) {
      MessageModel message = MessageModel.fromJson(snapshot.userChatGroupData.docs[index].userChatGroupData());
      if (message.userId == model.authenticationService.currentAppUser.email) {
        this.isMe = true;
      } else {
        this.isMe = false;
      }
      return MessageWidget(message: message, isMe: this.isMe);
    });
  }
}
