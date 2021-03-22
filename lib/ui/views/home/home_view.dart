import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zimster_messaging/models/appuser-model.dart';
import 'package:zimster_messaging/services/console_utility.dart';
// import 'package:zimster_messaging/services/console_utility.dart';
// import 'package:zimster_messaging/ui/views/chat/deprecared_chat_page.dart';
// import 'package:zimster_messaging/ui/views/chat/conversation_header.dart';
import 'package:zimster_messaging/ui/views/chat/chagroups_list.dart';
// import 'package:zimster_messaging/ui/views/chat/newMessage.dart';
import 'package:zimster_messaging/ui/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:contacts_service/contacts_service.dart';

///this class is the Default View of All  Authenticated [AppUserModel] app users
class HomeView extends StatelessWidget {
  // Contact _contact;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model)=> model.readContacts(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Zimmster Messenger'),
          centerTitle: true,
        ),
        body: body(model),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.chat_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            ConsoleUtility.printToConsole('navigate to Contacts');
            model.navigateToAppContactsListView();
          },
        ),
      ),
    );
  }

  Widget body(HomeViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatGroupsList(userId: model.currentAppUser.email),
    );
  }
}
