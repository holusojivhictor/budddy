part of 'buddy_bloc.dart';

@freezed
class BuddyEvent with _$BuddyEvent {
  const factory BuddyEvent.loadFromId({required String id}) = _LoadBuddyFromId;

  const factory BuddyEvent.connect({required String id}) = _Connect;
}
