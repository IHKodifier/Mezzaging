import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zimster_messaging/ui/views/appContacts/appContact_viewmodel.dart';

class AppContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppContactViewModel>.reactive(
      viewModelBuilder: () => AppContactViewModel(),
      builder: thisWidgetBuilder,
    );
  }

  thisWidgetBuilder(
      BuildContext context, AppContactViewModel model, Widget child) {
    return Container(
      height: 100,
      color: Colors.teal,
    );
  }
}
