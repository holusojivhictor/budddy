import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/domain/extensions/int_extensions.dart';
import 'package:buddy/presentation/shared/bottom_sheets/common_bottom_sheet.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/choice/choice_list_with_icon.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestsBottomSheet extends StatefulWidget {
  const InterestsBottomSheet({Key? key}) : super(key: key);

  @override
  State<InterestsBottomSheet> createState() => _InterestsBottomSheetState();
}

class _InterestsBottomSheetState extends State<InterestsBottomSheet> {
  late HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      title: 'Select at least 3 interests',
      showOkButton: false,
      showCancelButton: false,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        builder: (ctx, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChoiceListWithIcon<SportType>(
                values: SportType.values,
                selectedValues: state.tempSportTypes,
                choiceText: (val, _) => Assets.translateSportTypeToString(val),
                iconData: (val, _) => Assets.translateSportTypeToIcon(val),
                onSelected: (v) {
                  context.read<HomeBloc>().add(HomeEvent.sportTypesChanged(v));
                  context.read<HomeBloc>().add(const HomeEvent.applyFilterChanges());
                },
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Submit',
                enabled: state.tempSportTypes.length.validLength(3),
                hasLoading: _bloc.isLoading,
                onPressed: () async {
                  await _updateInterests(state.sportTypes).then((_) {
                    Navigator.pop(context);
                    _showSuccessToast();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateInterests(List<SportType> types) async {
    _refresh();
    await _bloc.updateInterests(types);
  }

  void _refresh() {
    setState(() {});
    return;
  }

  void _showSuccessToast() {
    final fToast = ToastUtils.of(context);
    ToastUtils.showSucceedToast(fToast, 'Interests successfully updated');
  }
}
