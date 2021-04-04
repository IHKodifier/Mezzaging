import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimster_messaging/ui/shared/busy_overlayBuilder.dart';
import 'package:zimster_messaging/ui/views/appContacts/appContacts_list_viewmodel.dart';

class AppContactsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppContactsListViewModel>.reactive(
        viewModelBuilder: () => AppContactsListViewModel(),
        onModelReady: (model) => model.initializeModel(),
        builder: (context, model, child) => Center(
          child: BusyOverlayBuilder(
                busyValue: model.isBusy,
                title: 'scanning your contacts...',
                childWhenIdle: Scaffold(
                  appBar: AppBar(
                    title: Text('Select contact'),
                  ),
                  body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                          // future: model.readDeviceContacts(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            else
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Contact contact = model.deviceContacts[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Card(
                                        elevation: 5,
                                        child: ListTile(
                                          leading: Icon(Icons.account_box),
                                          title: Text(contact.displayName),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              contact.company != null
                                                  ? Text(contact.company)
                                                  : Container(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      contact.phones.first.label),
                                                  // Flexible(child: child),
                                                  Text(
                                                      contact.phones.first.value),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                          })),
                ),
              ),
        ));
  }
}
