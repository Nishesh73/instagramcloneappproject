
class MessageModel{
  String toId;
  String fromId;
  var sentTime;
  var readTime;
  String message;
  String messageType;

  MessageModel({
    required this.toId,
     required this.fromId,
      required this.sentTime,
       required this.readTime,
        required this.message,
         required this.messageType,



  });

  Map<String, dynamic> toStoreInFirebase(){

    return{
       "toId": toId,
  "fromId": fromId,
  "sentTime": sentTime,
  "readTime": readTime,
  "message": message,
  "messageType": messageType



    };
 }

//  static MessageModel maptoRequiredData(){

//   return MessageModel(toId: toId, 
//   fromId: fromId, 
//   sentTime: sentTime, 
//   readTime: readTime, 
//   message: message, 
//   messageType: 
//   messageType);



//  }






}