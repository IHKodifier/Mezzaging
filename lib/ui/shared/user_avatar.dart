import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  final String photoURL;

  const UserAvatarWidget({Key key, this.photoURL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return photoURL == null
        ? Icon(
            Icons.account_circle,
            size: 40,
            color: Theme.of(context).primaryColor,
          )
        : Image.network(photoURL);
  }
}
