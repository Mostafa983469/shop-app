class LoginDate{
  late bool status;
  late String massage;
  UserData? data;


  LoginDate(Map<String,dynamic> json){
  status = json['status'];
  massage = json['message'];
  data = UserData(json['data']);
  }
}

class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData(Map<String,dynamic> Data){
    id = Data['id'];
    name = Data['name'];
    email = Data['email'];
    phone = Data['phone'];
    image = Data['image'];
    points = Data['points'];
    credit = Data['credit'];
    token = Data['token'];
  }
}