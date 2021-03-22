import 'package:flutter/material.dart';
import '../services/console_utility.dart';


class MessageField {
  static final String createdAt = 'createdAt';
}

class MessageModel {
  final String userId;
  final String photoURL;
  final String username;
  final String message;
  final DateTime createdAt;

  const MessageModel({
    @required this.userId,
    @required this.photoURL,
    @required this.username,
    @required this.message,
    @required this.createdAt,
  });

  static MessageModel fromJson(Map<String, dynamic> json) => MessageModel(
        userId: json['idUser'],
        photoURL: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        createdAt: ConsoleUtility.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': userId,
        'urlAvatar': photoURL,
        'username': username,
        'message': message,
        'createdAt': ConsoleUtility.fromDateTimeToJson(createdAt),
      };
}
