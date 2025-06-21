import 'package:ball/constants/data_constants.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:uuid/uuid.dart';

class UserProfile {
  String id = const Uuid().v1();
  String? name;
  TeamName? userTeam;
  GamePositions? position;
  Role? role;

  UserProfile({
    this.name, this.position, this.role, this.userTeam
    });

  UserProfile.fromData({required Map<String, dynamic> data})
    : id = data[UserDatabaseConstants.id],
    name = data[UserDatabaseConstants.name],
    userTeam = data[UserDatabaseConstants.userTeam],
      position = (data[UserDatabaseConstants.position] ?? '' ).isEmpty ? GamePositions.none : (data[UserDatabaseConstants.position] as String).position,
      role = (data[UserDatabaseConstants.role] ?? '').isEmpty ? Role.enthusiasts : (data[UserDatabaseConstants.role] as String).role ;

  Map<String, dynamic> toData() => {
    UserDatabaseConstants.id : id,
    UserDatabaseConstants.name: name,
    UserDatabaseConstants.position: position?.positionToString() ?? '',
    UserDatabaseConstants.userTeam: userTeam ?? '',
    UserDatabaseConstants.role: role ?? '',  
  };

  UserProfile copyWith({String? name, GamePositions? position, Role? role}) =>
      UserProfile(
        name: name ?? this.name,
        position: position ?? this.position,
        role: role ?? this.role,
        userTeam: userTeam ?? userTeam,
      );
}
