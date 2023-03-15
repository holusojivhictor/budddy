import 'package:buddy/application/bloc.dart';
import 'package:buddy/colors.dart';
import 'package:buddy/domain/assets.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/presentation/shared/buttons/primary_button.dart';
import 'package:buddy/presentation/shared/choice/display_chip_with_icon.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/presentation/shared/padded_text.dart';
import 'package:buddy/presentation/shared/utils/toast_utils.dart';
import 'package:buddy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuddyBottomSheet extends StatefulWidget {
  final String id;
  final String displayName;
  final List<SportType> interests;
  final bool isLoading;

  const BuddyBottomSheet({
    Key? key,
    required this.id,
    required this.displayName,
    required this.interests,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<BuddyBottomSheet> createState() => _BuddyBottomSheetState();
}

class _BuddyBottomSheetState extends State<BuddyBottomSheet> {
  late BuddyBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<BuddyBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Styles.edgeInsetAll10,
      padding: Styles.edgeInsetAll10,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: Styles.defaultCardBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PaddedText(
            'Interests',
            padding: const EdgeInsets.symmetric(horizontal: 5),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: getChips(context, widget.interests),
          ),
          const SizedBox(height: 20),
          InterestNote(
            displayName: widget.displayName,
            buddyInterests: widget.interests,
          ),
          const SizedBox(height: 10),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) {
                final buddyIds = state.friends.map((e) => e.id).toList();
                return PrimaryButton(
                  hasLoading: widget.isLoading,
                  enabled: !buddyIds.contains(widget.id),
                  text: buddyIds.contains(widget.id) ? 'Connected' : 'Connect',
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  onPressed: () => _connect(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _connect(BuildContext context) async {
    _bloc.add(BuddyEvent.connect(id: widget.id));
    _bloc.showToast.stream.listen((event) {
      if (event) {
        _showToast(context);
        setState(() {});
      }
    });
  }

  void _showToast(BuildContext context) {
    final fToast = ToastUtils.of(context);
    ToastUtils.showSucceedToast(fToast, 'Hurray! You have a new buddy!');
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

class InterestNote extends StatelessWidget {
  final String displayName;
  final List<SportType> buddyInterests;

  const InterestNote({
    Key? key,
    required this.displayName,
    required this.buddyInterests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) {
          final common = state.interests.toSet().intersection(buddyInterests.toSet());
          return PaddedText(
            common.isNotEmpty
                ? 'You have shared interests with $displayName. Connect with them to explore that to the fullest!'
                : "You don't have shared interests with $displayName. Connect with them to expand your knowledge base.",
            padding: const EdgeInsets.symmetric(horizontal: 5),
            style: Theme.of(context).textTheme.bodyMedium,
          );
        },
      ),
    );
  }
}
