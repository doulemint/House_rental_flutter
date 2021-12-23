import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String avatar;
  final String gender;
  final String nickname;
  
  final String phone;
  final int id;

  UserInfo(this.avatar, this.gender, this.nickname, this.phone, this.id);

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

    // UserInfo(
    //   json['avatar'] as String,
    //   json['gender'] as String,
    //   json['nickname'] as String,
    //   json['phone'] as String,
    //   json['id'] as int,
    // );

  Map<String, dynamic> toJson()=> _$UserInfoToJson(this);
}

//flutter packages pub run build_runner build
