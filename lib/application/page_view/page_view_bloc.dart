import 'package:buddy/domain/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_view_bloc.freezed.dart';
part 'page_view_event.dart';
part 'page_view_state.dart';

const _initialState = PageViewState.loaded();

class PageViewBloc extends Bloc<PageViewEvent, PageViewState> {
  final PageController pageController = PageController();

  PageViewBloc() : super(_initialState) {
    on<_Init>(_mapInitToState);
    on<_Next>(_mapNextToState);
    on<_Previous>(_mapPreviousToState);
    on<_OnPageChanged>(_mapOnPageChangedToState);
  }

  // ignore: library_private_types_in_public_api
  _LoadedState get currentState => state as _LoadedState;

  PageViewState _buildInitialState() {
    return PageViewState.loaded(
      controller: pageController,
    );
  }

  void _mapInitToState(_Init event, Emitter<PageViewState> emit){
    pageController.addListener(() {
      if (!pageController.hasClients) {
        return;
      }
      add(PageViewEvent.onPageChanged(page: pageController.page?.toInt() ?? 1));
    });
    emit(_buildInitialState());
  }

  void _mapOnPageChangedToState(_OnPageChanged event, Emitter<PageViewState> emit){
    final state = currentState.copyWith.call(
      page: event.page,
    );
    emit(state);
  }

  void _mapNextToState(_Next event, Emitter<PageViewState> emit){
    if (!pageController.hasClients) {
      return;
    }

    pageController.nextPage(duration: kAnimationDuration, curve: kCurve);
  }

  void _mapPreviousToState(_Previous event, Emitter<PageViewState> emit){
    if (!pageController.hasClients) {
      return;
    }

    pageController.previousPage(duration: kAnimationDuration, curve: kCurve);
  }

  @override
  Future<void> close() async {
    pageController.dispose();
    await super.close();
  }
}
