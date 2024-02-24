class UserModel {
  String? firstname;
  String? description;
  String? lastname;

  UserModel({this.firstname, this.description,this.lastname});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstname: json["firstname"],
    lastname: json["lastname"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "description": description,
  };
}