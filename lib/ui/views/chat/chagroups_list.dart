import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimster_messaging/app/service_locator.dart';
import 'package:zimster_messaging/models/chatGroup_model.dart';
import 'package:zimster_messaging/models/message_model.dart';
import 'package:zimster_messaging/services/authentication_service.dart';
import 'package:zimster_messaging/services/chat_service.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/ui/views/chat/chat_list_tile.dart';
import 'package:zimster_messaging/ui/views/chat/chatGroups_viewmodel.dart';
import 'package:zimster_messaging/ui/views/chat/messageWidget.dart';

/// this widget Lists all [ChatGroupModel]s the current user is [member] of
class ChatGroupsList extends StatelessWidget {
  final AuthenticationService authenticationService =
      serviceLocator<AuthenticationService>();
  final ChatService chatService = serviceLocator<ChatService>();
  final String userId;

  ChatGroupsList({
    @required this.userId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatGroupViewModel>.reactive(
      viewModelBuilder: () => ChatGroupViewModel(),
      builder: (context, model, child) => StreamBuilder(
        stream: model.getUserChatGroups(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                // return buildText('Something Went Wrong Try later');
                ConsoleUtility.printToConsole(snapshot.error.toString());
                return buildText(snapshot.error.toString());
              } else {
                final userChatGroups = snapshot.data;

                return userChatGroups == null
                    ? buildText('Say Hi..')
                    : ListView.builder(
        physics: BouncingScrollPhysics(),
        // reverse: true,
        itemCount: userChatGroups.docs.length,
        itemBuilder: (context, index) {
          ChatGroupModel chatGroupModel =
              ChatGroupModel.fromMap(userChatGroups.docs[index].data());
          final userChatGroup = userChatGroups.docs[index];
          return ChatGroupTile(
            // userChatGroupData: userChatGroup.data(),
            chatGroupModel: chatGroupModel,
            userId: userId,
          );
        });
              }
          }
        },
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );

 
}
