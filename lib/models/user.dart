class FireUser {
  final String id;
  final String email;
  final String username;
  final String photoUrl;
  final String displayName;
  final String bio;

  FireUser({required this.id,required this.email,required this.username,required this.photoUrl,required this.displayName,required this.bio});

FireUser.fromData(Map<String,dynamic> data)
  : id= data['id'],
    email=data['email'],
    username=data['username'],
    photoUrl=data['photoUrl'],
    displayName=data['displayName'],
    bio=data['bio'];

  Map<String,dynamic> toJson(){
  return {
    'id': id,
    'username': username,
    'photoUrl': photoUrl,
    'displayName': displayName,
    'bio': bio,


  };
  }

}





