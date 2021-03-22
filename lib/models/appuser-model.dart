// import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zimster_messaging/services/console_utility.dart';
import 'package:zimster_messaging/app/constants.dart' as constants;
// import 'package:firebase_auth/';

/// default [photoURL] if none provided
String _photoURLifBlank = constants.kPhotoURLIfBlank;
// 'https://st4.depositphotos.com/15973376/24173/v/950/depositphotos_241732228-stock-illustration-user-account-circular-line-icon.jpg';

class AppUserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class AppUserModel {
  String fireAuthUid;
  String userId;
  String email;
  String displayName;
  // final String lastName;
  // final String userRoles;
  String photoURL;
  String providerId;
  DateTime lastMessageTime;

  AppUserModel(
      {this.fireAuthUid,
      this.userId,
      this.displayName,
      this.providerId,
      // this.lastName,
      this.email,
      // this.profileTitle,
      // this.userRoles,
      this.photoURL,
      this.lastMessageTime});

  AppUserModel.fromUserCredential(
      {UserCredential userCredential, String providerId}) {
    switch (providerId) {
      case 'Phone':
        this.userId = userCredential.user.phoneNumber;
        displayName = 'User@  ${userCredential.user.phoneNumber}';
        this.photoURL = '';
        this.email = '';
        break;
      case 'Email':
        this.userId = userCredential.user.email;
        this.displayName = userCredential.user.email;
        this.photoURL = '';
        break;
      default:
        this.userId = userCredential.user.email;
        this.displayName = userCredential.user.email;
        this.photoURL = userCredential.user.photoURL;
        this.email = userCredential.user.email;
    this. providerId = providerId;
    }

    fireAuthUid = userCredential.user.uid;
  }

  AppUserModel.fromData(Map<String, dynamic> data, String providerId)
      : fireAuthUid = data['fireAuthUid'],
        displayName = data['displayName'],
        userId = data['userId'],
        email = data['email'],
        providerId = providerId,
        photoURL = data['photoURL'],
        lastMessageTime = ConsoleUtility.toDateTime(data['lastMessageTime']);

  static AppUserModel fromJson(Map<String, dynamic> data) => AppUserModel(
        fireAuthUid: data['fireAuthUid'],
        displayName: data['displayName'],
        userId: data['userId'],
        email: data['email'],
        photoURL: data['photoURL'],
        // providerId=data['providerId'],
        lastMessageTime: ConsoleUtility.toDateTime(data['lastMessageTime']),
      );

  Map<String, dynamic> toJson() {
    return {
      'fireAuthUid': fireAuthUid,
      'displayName': displayName,
      'userId': userId,
      // 'lastName': lastName,
      'email': email,
      // 'profileTitle': profileTitle,
      // 'userRoles': userRoles,
      'providerId': this.providerId,
      'photoURL': photoURL,
      'lastMessageTime': ConsoleUtility.fromDateTimeToJson(lastMessageTime),
    };
  }

  String toPrint() {
    String str;
    str =
        ' ${this.displayName}\n ${this.email}\n ${this.photoURL}\n${this.providerId}\n${this.fireAuthUid}';
    return str;
  }
}


  /// Parked for Future

    // AppUserModel copyWith({
    //   String uid,
    //   String email,
    //   String displayName,
    //   // final String lastName;
    //   // final String userRoles;
    //   String photoURL,
    //   String providerId,
  //  ) =>
  //       AppUserModel(
  //         fireAuthUid:  uid ?? this.fireAuthUid,
  //         displayName: displayName ?? this.displayName,
  //         email: email ?? this.email,
  //         photoURL: photoURL ?? this.photoURL,
  //       );