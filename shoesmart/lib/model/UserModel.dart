class UserModel 
{
  int userpk;
  String userid;
  String password;

  UserModel({this.userpk, this.userid, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    userpk = json['userpk'];
    userid = json['userid'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['pk'] = this.pk;
    data['userid'] = this.userid;
    data['password'] = this.password;
    return data;
  }
}
