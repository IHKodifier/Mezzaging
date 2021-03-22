class ChatGroupModel {
  final String chatGroupId;
  String title;
  bool isGroup;
  bool isDeleted;
  bool isPinned;
  bool isMe=null;
  List<dynamic> members;

  ChatGroupModel(this.chatGroupId, this.title);

  ChatGroupModel.fromMap(Map<String, dynamic> data)
      : chatGroupId = data['chatGroupId'],
        isGroup = data['isGroup'],
        isDeleted = data['isDeleted'],
        
        isPinned = data['isPinned'],
        members = data['members'],
        title = data['title'];
}
