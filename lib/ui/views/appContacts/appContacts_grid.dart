import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:zimster_messaging/ui/views/appContacts/appContacts_grid_viewmodel.dart';

class AppContactsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppContactsGridViewModel>.reactive(
      viewModelBuilder: () => AppContactsGridViewModel(),
      onModelReady: (model) => model.initModel,
      builder: thisWidgetBuilder,
    );
  }

  thisWidgetBuilder(
    BuildContext context,
    AppContactsGridViewModel model,
    Widget child,
  ) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 16 / 9.889),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            height: 80,
            child: Card(
              // alignment: Alignment.center,
              // color: Colors.teal[100 * (index % 9)],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    // backgroundColor: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          );
        },
        childCount: 80,
      ),
    );
  }
}
