class ChatUserModel{

  late String image;
  late String about;
  late String name;
  late  final createdAt;
   late final isOnline;
  late String id;
  late  final lastActive;
   late String email;
  late String pushToken;

  ChatUserModel({required this.image, required this.about, required this.name, required this.createdAt,
  required this.isOnline, required this.id, required this.lastActive, required this.email,
  required this.pushToken});

  

  Map<String, dynamic> toChatMapData(){

    return{
        "image": image,
        "about": about,
        "name": name,
        "createdAt": createdAt,
         "isOnline": isOnline,
         "id": id,
         "lastActive": lastActive,
         "email": email,
         "pushToken": pushToken,
        


    };


  }  

  // static ChatUserModel mapToRequiredData(){

    // return ChatUserModel(image: 
    // image, 
    // about: 
    // about, name: name, createdAt: createdAt, isOnline: isOnline, id: id, lastActive: lastActive, email: email, pushToken: pushToken)



  // }




  








}