// ignore_for_file: must_be_immutable


class User {

  String? name;
  String? email;
  String? otp;
  bool? verified;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.name,
      this.email,
      this.otp,
      this.verified,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    otp = json['otp'];
    verified = json['verified'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['otp'] = otp;
    data['verified'] = verified;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }


}

