import 'dart:async';
import 'dart:convert';

import 'package:ball/state/data/offline_storage/offline_storage_functions.dart';
import 'package:ball/state/models/errors/errors.dart';

import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user/user_profile.dart';

part 'user_profile_notifier.g.dart';

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Stream<Either<AppError, UserProfile>> build() async* {
    final controller = StreamController<Either<AppError, UserProfile>>();

    final sub = userDatabase.watchUserData().listen((data) async {
      if (data.isEmpty) {
        controller.add(const Left(AppError(message: 'No User')));
      } else {
        final userDataString = data.first;
        final profile = UserProfile.fromData(data: jsonDecode(userDataString));

        controller.add(Right(profile));
      }
    });
    // if (data.isEmpty) {
    //     controller.add(const Left(AppError(message: 'NO user')));
    //     data.debugLog(message: 'no user: userNotifier Provider');
    //   } else {
    //     data.map((data) {
    //       final profile = UserProfile.fromData(data: jsonDecode(data));
    //       controller.add(Right(profile));
    //     });
    //   }

    await for (final profile in controller.stream) {
      yield profile;
    }

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
  }

  final userDatabase = UserProfileFunctions.instance;

  Future<void> createUser({required UserProfile user}) async {
    final data = user.toData();

    await userDatabase.createUser(userData: data);
  }

  Future<void> updateUser({required UserProfile user}) async {
    final data = user.copyWith(
      name: user.name,
      position: user.position,
      role: user.role,
    );

    final updatedUser = data.toData();

    await userDatabase.updateUser(userData: updatedUser);
  }

  void deleteUser({required UserProfile user}) {
    userDatabase.deleteUser();
  }
}
