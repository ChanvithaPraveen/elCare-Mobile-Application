class UserDetails{
  String? displayName;
  String? email;
  String? photoURL;

  UserDetails({this.displayName,this.email,this.photoURL});

  UserDetails.fromJson(Map<String, dynamic>json){
    displayName = json["displayName"];
    photoURL = json["photoURL"];
    email = json["email"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["displayName"] = this.displayName;
    data["email"] = this.email;
    data["photoURL"] = this.photoURL;
    return data;
  }
}