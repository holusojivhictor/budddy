import 'package:buddy/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = _IdleState<T>;

  const factory ResultState.loading() = _LoadingState<T>;

  const factory ResultState.refresh() = __Refresh<T>;

  const factory ResultState.data({
    T? data,
  }) = _DataState<T>;

  const factory ResultState.error({
    required NetworkExceptions error,
  }) = _ErrorState<T>;
}
