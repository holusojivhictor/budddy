import 'package:buddy/domain/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddies_bloc.freezed.dart';
part 'buddies_event.dart';
part 'buddies_state.dart';

class BuddiesBloc extends Bloc<BuddiesEvent, BuddiesState> {
  BuddiesBloc() : super(const BuddiesState.loading());
}
