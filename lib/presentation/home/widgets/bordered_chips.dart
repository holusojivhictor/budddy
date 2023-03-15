import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/presentation/shared/choice/display_chip_with_icon.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BorderedChips extends StatelessWidget {
  const BorderedChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: Styles.edgeInsetHorizontal16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interests',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (state.interests.isEmpty)
                      IconButton(
                        padding: const EdgeInsets.only(left: 12),
                        onPressed: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.interests),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.grey6, width: 1.5),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: state.interests.isEmpty
                    ? Styles.edgeInsetHorizontal16
                    : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: getChips(context, state.interests),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getChips(BuildContext context, List<SportType> types) {
    return types.map((e) => _buildChip(e)).toList();
  }

  Widget _buildChip(SportType type) {
    return DisplayChipWithIcon(
      valueText: Assets.translateSportTypeToString(type),
      iconData: Assets.translateSportTypeToIcon(type),
    );
  }
}
