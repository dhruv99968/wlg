/*
import 'dart:convert';

class User{

  String? _id;
  String? _email;
  String? _firstName;
  String? _role;
  String? _phoneNumber;
  dynamic _age;
  String? _createdAt;
  dynamic _profession;
  String? _fbUrl;
  String? _instaUrl;
  String? _twitterUrl;
  String? _profilePicture;
  String? _profilePictureThumbnail;
  String? _password;
  User( {
    String? id,

    String? email,
    String? firstName,
    String? role,
    String? phoneNumber,
    dynamic age,
    String? createdAt,
    dynamic profession,
    String? fbUrl,
    String? instaUrl,
    String? twitterUrl,
    String? profilePicture,
    String? profilePictureThumbnail,  String? password,
  });
{
    _id = id!;
    _email = email!;
    _firstName = firstName!;
    _role = role!;
    _phoneNumber = phoneNumber!;
    _age = age!;
    _createdAt = createdAt!;
    _profession = profession!;
    _fbUrl = fbUrl!;
    _instaUrl = instaUrl!;
    _twitterUrl = twitterUrl!;
    _profilePicture = profilePicture!;
    _profilePictureThumbnail = profilePictureThumbnail!;
  }
 Map<String,dynamic> toMap(){
    return{
      'firstName':name,
      'profile_picture':path,
     // 'phone_number':number,
     // 'age':age,
     // 'profession':profession
    };
  }

 factory User.fromMap(Map<String,dynamic> map){
    return User(
        _id = json["id"],
        _email = json['email'],
        _firstName = json['firstName'],
        _role = json['role'],
        _phoneNumber = json['phone_number'],
        _age = json['age'],
        _createdAt = json['created_at'],
        _profession = json['profession'],
        _fbUrl = json['fb_url'],
        _instaUrl = json['insta_url'],
        _twitterUrl = json['twitter_url'],
        _profilePicture = json['profile_picture'],
        _profilePictureThumbnail = json['profile_picture_thumbnail']
    );
  }
}*/
