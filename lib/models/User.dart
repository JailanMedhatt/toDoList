
class MyUser{
  String? email;
  String? name;
  String? id;
  MyUser({required this.email, required this.id, required this.name});
  MyUser.fromFireStore(Map<String, dynamic> data):this(email: data["email"],id: data["id"], name: data["name"]);
  Map<String, dynamic> toFireStore(){
    return{
      "email": email,
      "name": name,
      "id":id
    };
}
}