import 'dart:async';

import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';

abstract class BuddyAppService {
  StreamController<bool> get isLoading;

  Future<void> init();

  Future<void> initBuddies();

  List<BuddyFileModel> get buddiesData;

  BuddyFileModel get currentUser;

  BuddyFileModel getBuddyFromId(String id);

  List<BuddyCardModel> getBuddiesForCard();

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
