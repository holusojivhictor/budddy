part of 'page_view_bloc.dart';

@freezed
class PageViewEvent with _$PageViewEvent {
  const factory PageViewEvent.init() = _Init;

  const factory PageViewEvent.next() = _Next;

  const factory PageViewEvent.previous() = _Previous;

  const factory PageViewEvent.onPageChanged({required int page}) = _OnPageChanged;
}
