import 'dart:async';

import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';

abstract class BuddyAppService {
  Future<void> init();

  Future<void> initBuddies();

  List<BuddyFileModel> get buddiesData;

  BuddyFileModel get currentUser;

  StreamController<bool> get isLoading;

  Future<void> updateCurrentUser(
    String displayName,
    String emailAddress,
  );

  Future<void> updateUserInterests({
    required List<SportType> interests,
  });

  Future<void> updateUserFriends({
    required String buddyId,
  });

  UserProfileModel getUserForProfile();
}
