/// success : true
/// message : "Logged in successfully."
/// data : {"id":"9769d241-3a27-4bd4-aeef-895eb8485bf5","role":1,"name":"hunggg","email":"hactieuho96@gmail.com","email_verified_at":"2022-10-04T06:56:12.000000Z","gender":0,"birth":"16/01/2002","avatar_path":"https://d37c8ertxcodlq.cloudfront.net/uploads/profiles/20221118/1668734211.1PQUI4IygPalSNL5VvJ57vSdRp4qvW5T345s230u.jpg","confirmation_code":null,"created_at":"2022-10-03T14:32:28.000000Z","updated_at":"2022-11-21T04:47:18.000000Z","deleted_at":null,"twitter":"571432663","facebook":"571432663","discord":"571432663","telegram":"571432663","jwt":{"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vc3RnLXVzZXIucGxhdHMubmV0d29yay9hcGkvbG9naW4iLCJpYXQiOjE2NjkwMDg2NTcsImV4cCI6MTY3MTYwMDY1NywibmJmIjoxNjY5MDA4NjU3LCJqdGkiOiJrZ1pXRmpRcWsyb2lxNVBGIiwic3ViIjoiOTc2OWQyNDEtM2EyNy00YmQ0LWFlZWYtODk1ZWI4NDg1YmY1IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyIsImlkIjoiOTc2OWQyNDEtM2EyNy00YmQ0LWFlZWYtODk1ZWI4NDg1YmY1Iiwicm9sZSI6MSwibmFtZSI6Imh1bmdnZyIsImVtYWlsIjoiaGFjdGlldWhvOTZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTEwLTA0VDA2OjU2OjEyLjAwMDAwMFoiLCJnZW5kZXIiOjAsImJpcnRoIjoiMTYvMDEvMjAwMiIsImF2YXRhcl9wYXRoIjoiaHR0cHM6Ly9kMzdjOGVydHhjb2RscS5jbG91ZGZyb250Lm5ldC91cGxvYWRzL3Byb2ZpbGVzLzIwMjIxMTE4LzE2Njg3MzQyMTEuMVBRVUk0SXlnUGFsU05MNVZ2SjU3dlNkUnA0cXZXNVQzNDVzMjMwdS5qcGciLCJjb25maXJtYXRpb25fY29kZSI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMjItMTAtMDNUMTQ6MzI6MjguMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTExLTIxVDA0OjQ3OjE4LjAwMDAwMFoiLCJkZWxldGVkX2F0IjpudWxsLCJ0d2l0dGVyIjoiNTcxNDMyNjYzIiwiZmFjZWJvb2siOm51bGwsImRpc2NvcmQiOm51bGwsInRlbGVncmFtIjpudWxsfQ.ZJ4lACTu9rXSUA8r2XhGkMxHPdwvIZu9forfddN7FuI","token_type":"bearer","expires_in":870912000}}

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.data,
  });

  LoginResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : "9769d241-3a27-4bd4-aeef-895eb8485bf5"
/// role : 1
/// name : "hunggg"
/// email : "hactieuho96@gmail.com"
/// email_verified_at : "2022-10-04T06:56:12.000000Z"
/// gender : 0
/// birth : "16/01/2002"
/// avatar_path : "https://d37c8ertxcodlq.cloudfront.net/uploads/profiles/20221118/1668734211.1PQUI4IygPalSNL5VvJ57vSdRp4qvW5T345s230u.jpg"
/// confirmation_code : null
/// created_at : "2022-10-03T14:32:28.000000Z"
/// updated_at : "2022-11-21T04:47:18.000000Z"
/// deleted_at : null
/// twitter : "571432663"
/// facebook : "571432663"
/// discord : "571432663"
/// telegram : "571432663"
/// jwt : {"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vc3RnLXVzZXIucGxhdHMubmV0d29yay9hcGkvbG9naW4iLCJpYXQiOjE2NjkwMDg2NTcsImV4cCI6MTY3MTYwMDY1NywibmJmIjoxNjY5MDA4NjU3LCJqdGkiOiJrZ1pXRmpRcWsyb2lxNVBGIiwic3ViIjoiOTc2OWQyNDEtM2EyNy00YmQ0LWFlZWYtODk1ZWI4NDg1YmY1IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyIsImlkIjoiOTc2OWQyNDEtM2EyNy00YmQ0LWFlZWYtODk1ZWI4NDg1YmY1Iiwicm9sZSI6MSwibmFtZSI6Imh1bmdnZyIsImVtYWlsIjoiaGFjdGlldWhvOTZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTEwLTA0VDA2OjU2OjEyLjAwMDAwMFoiLCJnZW5kZXIiOjAsImJpcnRoIjoiMTYvMDEvMjAwMiIsImF2YXRhcl9wYXRoIjoiaHR0cHM6Ly9kMzdjOGVydHhjb2RscS5jbG91ZGZyb250Lm5ldC91cGxvYWRzL3Byb2ZpbGVzLzIwMjIxMTE4LzE2Njg3MzQyMTEuMVBRVUk0SXlnUGFsU05MNVZ2SjU3dlNkUnA0cXZXNVQzNDVzMjMwdS5qcGciLCJjb25maXJtYXRpb25fY29kZSI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMjItMTAtMDNUMTQ6MzI6MjguMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTExLTIxVDA0OjQ3OjE4LjAwMDAwMFoiLCJkZWxldGVkX2F0IjpudWxsLCJ0d2l0dGVyIjoiNTcxNDMyNjYzIiwiZmFjZWJvb2siOm51bGwsImRpc2NvcmQiOm51bGwsInRlbGVncmFtIjpudWxsfQ.ZJ4lACTu9rXSUA8r2XhGkMxHPdwvIZu9forfddN7FuI","token_type":"bearer","expires_in":870912000}

class Data {
  Data({
    this.id,
    this.role,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.birth,
    this.avatarPath,
    this.confirmationCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.twitter,
    this.facebook,
    this.discord,
    this.telegram,
    this.jwt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    birth = json['birth'];
    avatarPath = json['avatar_path'];
    confirmationCode = json['confirmation_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    discord = json['discord'];
    telegram = json['telegram'];
    jwt = json['jwt'] != null ? Jwt.fromJson(json['jwt']) : null;
  }
  String? id;
  num? role;
  String? name;
  String? email;
  String? emailVerifiedAt;
  num? gender;
  String? birth;
  String? avatarPath;
  dynamic confirmationCode;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? twitter;
  String? facebook;
  String? discord;
  String? telegram;
  Jwt? jwt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role'] = role;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['gender'] = gender;
    map['birth'] = birth;
    map['avatar_path'] = avatarPath;
    map['confirmation_code'] = confirmationCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['twitter'] = twitter;
    map['facebook'] = facebook;
    map['discord'] = discord;
    map['telegram'] = telegram;
    if (jwt != null) {
      map['jwt'] = jwt?.toJson();
    }
    return map;
  }
}

/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vc3RnLXVzZXIucGxhdHMubmV0d29yay9hcGkvbG9naW4iLCJpYXQiOjE2NjkwMDg2NTcsImV4cCI6MTY3MTYwMDY1NywibmJmIjoxNjY5MDA4NjU3LCJqdGkiOiJrZ1pXRmpRcWsyb2lxNVBGIiwic3ViIjoiOTc2OWQyNDEtM2EyNy00YmQ0LWFlZWYtODk1ZWI4NDg1YmY1IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyIsImlkIjoiOTc2OWQyNDEtM2EyNy00YmQ0LWFlZWYtODk1ZWI4NDg1YmY1Iiwicm9sZSI6MSwibmFtZSI6Imh1bmdnZyIsImVtYWlsIjoiaGFjdGlldWhvOTZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTEwLTA0VDA2OjU2OjEyLjAwMDAwMFoiLCJnZW5kZXIiOjAsImJpcnRoIjoiMTYvMDEvMjAwMiIsImF2YXRhcl9wYXRoIjoiaHR0cHM6Ly9kMzdjOGVydHhjb2RscS5jbG91ZGZyb250Lm5ldC91cGxvYWRzL3Byb2ZpbGVzLzIwMjIxMTE4LzE2Njg3MzQyMTEuMVBRVUk0SXlnUGFsU05MNVZ2SjU3dlNkUnA0cXZXNVQzNDVzMjMwdS5qcGciLCJjb25maXJtYXRpb25fY29kZSI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMjItMTAtMDNUMTQ6MzI6MjguMDAwMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTExLTIxVDA0OjQ3OjE4LjAwMDAwMFoiLCJkZWxldGVkX2F0IjpudWxsLCJ0d2l0dGVyIjoiNTcxNDMyNjYzIiwiZmFjZWJvb2siOm51bGwsImRpc2NvcmQiOm51bGwsInRlbGVncmFtIjpudWxsfQ.ZJ4lACTu9rXSUA8r2XhGkMxHPdwvIZu9forfddN7FuI"
/// token_type : "bearer"
/// expires_in : 870912000

class Jwt {
  Jwt({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  Jwt.fromJson(dynamic json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }
  String? accessToken;
  String? tokenType;
  num? expiresIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    return map;
  }
}
