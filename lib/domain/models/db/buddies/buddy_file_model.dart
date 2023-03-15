import 'package:buddy/domain/enums/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddy_file_model.freezed.dart';
part 'buddy_file_model.g.dart';

@freezed
class BuddyFileModel with _$BuddyFileModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  factory BuddyFileModel({
    @Default('') String referenceId,
    required String id,
    required String displayName,
    required String emailAddress,
    String? phoneNumber,
    required String avatarSource,
    required List<SportType> sportInterests,
    required List<FriendModel> friends,
  }) = _BuddyFileModel;

  BuddyFileModel._();

  factory BuddyFileModel.fromSnapshot(DocumentSnapshot snapshot) {
    final buddy = BuddyFileModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return buddy.copyWith.call(referenceId: snapshot.reference.id);
  }

  factory BuddyFileModel.fromJson(Map<String, dynamic> json) => _$BuddyFileModelFromJson(json);
}

@freezed
class FriendModel with _$FriendModel {
  factory FriendModel({
    required String id,
    required String displayName,
    required String avatarSource,
    required List<SportType> sportInterests,
  }) = _FriendModel;

  FriendModel._();

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);
}
