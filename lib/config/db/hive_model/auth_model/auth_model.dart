import 'package:hive_flutter/hive_flutter.dart';

import '../mock_auth/mock_auth.model.dart';
part 'auth_model.g.dart';

@HiveType(typeId: 2)
class AuthEntity extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  UserInfoModel userInfo;

  AuthEntity({required this.email, required this.userInfo});
}

