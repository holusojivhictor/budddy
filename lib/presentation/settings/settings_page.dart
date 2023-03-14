import 'package:buddy/presentation/settings/widgets/settings_bottom_view.dart';
import 'package:buddy/presentation/settings/widgets/settings_top_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, size) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SettingsTopView(),
                  ],
                ),
              ),
              const Expanded(
                flex: 70,
                child: SettingsBottomView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
