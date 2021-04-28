import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/ui/shared/busy_overlayBuilder.dart';
import 'package:zimster_messaging/ui/views/appContacts/appContacts_list_viewmodel.dart';

class AppContactsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppContactsListViewModel>.reactive(
      viewModelBuilder: () => AppContactsListViewModel(),
      builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: Text('Select contact'),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: viewModel.searchContact,
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                ),
                onPressed: viewModel.refreshContacts,
              ),
              SizedBox(width: 20),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.addressCard),
                onPressed: viewModel.newContact,
              ),
              SizedBox(width: 20),
            ],
          ),
          body: StreamBuilder(
              stream: viewModel.stream, builder: contactTileBuilder)),
    );
  }

  Widget contactTileBuilder(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return !snapshot.hasData
        // ? SpinKitThreeBounce(
        //     color: Theme.of(context).primaryColor,
        //   )
        ? buildBusy(context)
        : RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(milliseconds: 3000));
            },
            child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  ConsoleUtility.printToConsole( snapshot.data.docs[index].runtimeType.toString());
                  return ListTile(
                      title: Text(
                    snapshot.data.docs[index].data()['userId'],
                  ));
                }),
          );
  }

// }
  Center buildBusy(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Updating your contacts',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
