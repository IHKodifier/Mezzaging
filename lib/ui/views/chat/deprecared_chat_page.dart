// import 'package:flutter/material.dart';
// import 'package:zimster_messaging/app/service_locator.dart';
// import 'package:zimster_messaging/models/app_user.dart';
// import 'package:zimster_messaging/models/message.dart';
// import 'package:zimster_messaging/services/authentication_service.dart';
// import 'package:zimster_messaging/ui/views/chat/conversation_header.dart';
// import '../../../services/chat_service.dart';

// class ChatPage extends StatefulWidget {
//   final AppUser appUser;

//   const ChatPage({
//     @required this.appUser,
//     Key key,
//   }) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: Colors.blue,
//         body: SafeArea(
//           child: Column(
//             children: [
//               ConversationHeaderWidget(name: widget.appUser.displayName),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25),
//                     ),
//                   ),
//                   child: MessagesWidget(idUser: widget.appUser.uid),
//                 ),
//               ),
//               NewMessageWidget(idUser: widget.appUser.uid)
//             ],
//           ),
//         ),
//       );
// }

// class NewMessageWidget extends StatefulWidget {
//   final String idUser;

//   const NewMessageWidget({
//     @required this.idUser,
//     Key key,
//   }) : super(key: key);

//   @override
//   _NewMessageWidgetState createState() => _NewMessageWidgetState();
// }

// class _NewMessageWidgetState extends State<NewMessageWidget> {
//   AuthenticationService authenticationService =
//       serviceLocator<AuthenticationService>();
//   final _controller = TextEditingController();
//   String message = '';

//   void sendMessage() async {
//     FocusScope.of(context).unfocus();

//     await ChatService.uploadMessage(
//         authenticationService.currentAppUser.uid, message);

//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) => Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(8),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: TextField(
//                 controller: _controller,
//                 textCapitalization: TextCapitalization.sentences,
//                 autocorrect: true,
//                 enableSuggestions: true,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   labelText: 'Type your message',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(width: 0),
//                     gapPadding: 10,
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 onChanged: (value) => setState(() {
//                   message = value;
//                 }),
//               ),
//             ),
//             SizedBox(width: 20),
//             GestureDetector(
//               onTap: message.trim().isEmpty ? null : sendMessage,
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue,
//                 ),
//                 child: Icon(Icons.send, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       );
// }

// // class ProfileHeaderWidget extends StatelessWidget {
// //   final String name;

// //   const ProfileHeaderWidget({
// //     @required this.name,
// //     Key key,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) => Container(
// //         height: 80,
// //         padding: EdgeInsets.all(16).copyWith(left: 0),
// //         child: Column(
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 BackButton(color: Colors.white),
// //                 Expanded(
// //                   child: Text(
// //                     name,
// //                     style: TextStyle(
// //                       fontSize: 24,
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //                 Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     buildIcon(Icons.call),
// //                     SizedBox(width: 12),
// //                     buildIcon(Icons.videocam),
// //                   ],
// //                 ),
// //                 SizedBox(width: 4),
// //               ],
// //             )
// //           ],
// //         ),
// //       );

// //   Widget buildIcon(IconData icon) => Container(
// //         padding: EdgeInsets.all(5),
// //         decoration: BoxDecoration(
// //           shape: BoxShape.circle,
// //           color: Colors.white54,
// //         ),
// //         child: Icon(icon, size: 25, color: Colors.white),
// //       );
// // }

// class MessagesWidget extends StatelessWidget {
//   final AuthenticationService authenticationService =
//       serviceLocator<AuthenticationService>();
//   final String idUser;

//    MessagesWidget({
//     @required this.idUser,
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => StreamBuilder<List<Message>>(
//         stream: ChatService.getMessages(idUser),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
// //               return Center(child:  SpinKitThreeBounce(
//             color: Theme.of(context).primaryColor,
//             size: 30,
//           ),);
//             default:
//               if (snapshot.hasError) {
//                 return buildText('Something Went Wrong Try later');
//               } else {
//                 final messages = snapshot.data;

//                 return messages.isEmpty
//                     ? buildText('Say Hi..')
//                     : ListView.builder(
//                         physics: BouncingScrollPhysics(),
//                         reverse: true,
//                         itemCount: messages.length,
//                         itemBuilder: (context, index) {
//                           final message = messages[index];

//                           return MessageWidget(
//                             message: message,
//                             isMe: message.userId == authenticationService.currentAppUser.uid,
//                           );
//                         },
//                       );
//               }
//           }
//         },
//       );

//   Widget buildText(String text) => Center(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 24),
//         ),
//       );
// }

// class MessageWidget extends StatelessWidget {
//   final Message message;
//   final bool isMe;

//   const MessageWidget({
//     @required this.message,
//     @required this.isMe,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final radius = Radius.circular(12);
//     final borderRadius = BorderRadius.all(radius);

//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: <Widget>[
//         if (!isMe)
//           CircleAvatar(
//               radius: 16,
//               backgroundImage: NetworkImage(
//                 message.photoURL,
//               )),
//         Container(
//           padding: EdgeInsets.all(16),
//           margin: EdgeInsets.all(16),
//           constraints: BoxConstraints(maxWidth: 140),
//           decoration: BoxDecoration(
//             color: isMe ? Colors.grey[100] : Theme.of(context).accentColor,
//             borderRadius: isMe
//                 ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
//                 : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
//           ),
//           child: buildMessage(),
//         ),
//       ],
//     );
//   }

//   Widget buildMessage() => Column(
//         crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             message.message,
//             style: TextStyle(color: isMe ? Colors.black : Colors.white),
//             textAlign: isMe ? TextAlign.end : TextAlign.start,
//           ),
//         ],
//       );
// }
