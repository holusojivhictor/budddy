import 'dart:async';

import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/models/models.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuddyAppServiceImpl implements BuddyAppService {
  final AuthService _authService;
  late List<BuddyFileModel> _buddiesFile;

  BuddyAppServiceImpl(this._authService);

  final collection = FirebaseFirestore.instance.collection('buddies');

  @override
  Future<void> init() async {
    await Future.wait([
      initBuddies(),
    ]);
  }

  @override
  Future<void> initBuddies() async {
    final json = await collection.get();
    final jsonList = json.docs.map((e) => BuddyFileModel.fromSnapshot(e)).toList();
    _buddiesFile = jsonList;
    _initStream();
  }

  void _initStream() {
    collection.snapshots().listen((snapshot) {
      final jsonList = snapshot.docs.map((e) => BuddyFileModel.fromSnapshot(e)).toList();
      _buddiesFile = jsonList;
    });
  }

  @override
  BuddyFileModel getBuddyFromId(String id) {
    return _buddiesFile.firstWhere((el) => el.id == id);
  }

  @override
  List<BuddyCardModel> getBuddiesForCard() {
    final buddies = _buddiesFile.toList();
    buddies.removeWhere((el) => el.id == _authService.currentUser.id);
    return buddies.map(_toBuddyForCard).toList();
  }

  @override
  List<BuddyFileModel> get buddiesData => _buddiesFile;

  @override
  BuddyFileModel get currentUser => _getBuddyFromList(_authService.currentUser.id);

  @override
  Future<void> updateCurrentUser(
    String displayName,
    String emailAddress,
  ) async {
    isLoading.add(true);
    await _authService.updateUser(email: emailAddress, displayName: displayName);
    final updatedData = currentUser.copyWith.call(
      displayName: displayName,
      emailAddress: emailAddress,
    );
    await collection.doc(currentUser.referenceId).update(updatedData.toJson());
    isLoading.add(false);
  }

  @override
  Future<void> updateUserInterests({
    required List<SportType> interests,
  }) async {
    isLoading.add(true);
    final updatedData = currentUser.copyWith.call(
      sportInterests: currentUser.sportInterests.toList()..addAll(interests),
    );
    await collection.doc(currentUser.referenceId).update(updatedData.toJson());
    isLoading.add(false);
  }

  @override
  Future<void> updateUserFriends({
    required String buddyId,
  }) async {
    final friend = _getBuddyFromList(buddyId);

    final updatedData = currentUser.copyWith.call(
      friends: currentUser.friends.toList()..add(
          FriendModel(
            id: friend.id,
            displayName: friend.displayName,
            avatarSource: friend.avatarSource,
            sportInterests: friend.sportInterests,
          ),
        ),
    );
    await collection.doc(currentUser.referenceId).update(updatedData.toJson());
  }

  BuddyFileModel _getBuddyFromList(String userId) {
    return _buddiesFile.firstWhere((el) => el.id == userId);
  }

  @override
  UserProfileModel getUserForProfile() {
    return _toProfileForCard(currentUser);
  }

  BuddyCardModel _toBuddyForCard(BuddyFileModel model) {
    return BuddyCardModel(
      id: model.id,
      displayName: model.displayName,
      avatarSource: model.avatarSource,
      interests: model.sportInterests,
      friends: model.friends.map((e) {
        return FriendCardModel(
          id: e.id,
          displayName: e.displayName,
          avatarSource: e.avatarSource,
          interests: e.sportInterests,
        );
      }).toList(),
    );
  }

  UserProfileModel _toProfileForCard(BuddyFileModel model) {
    return UserProfileModel(
      displayName: model.displayName,
      emailAddress: model.emailAddress,
      phoneNumber: model.phoneNumber,
      avatarSource: model.avatarSource,
      interests: model.sportInterests,
      friends: model.friends.map((e) {
        return FriendCardModel(
          id: e.id,
          displayName: e.displayName,
          avatarSource: e.avatarSource,
          interests: e.sportInterests,
        );
      }).toList(),
    );
  }

  @override
  final StreamController<bool> isLoading = StreamController.broadcast();
}
