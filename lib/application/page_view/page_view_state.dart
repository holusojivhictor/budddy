part of 'page_view_bloc.dart';

@freezed
class PageViewState with _$PageViewState {
  const factory PageViewState.loaded({
    PageController? controller,
    @Default(0) int page,
  }) = _LoadedState;
}
