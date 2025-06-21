import 'package:ball/components/loading_indicator.dart';
import 'package:ball/pages/main_page.dart';
import 'package:ball/pages/onboarding/onboarding.dart';
import 'package:ball/state/models/utils/ext.dart';
// import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/notifier/user_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Gateway extends HookConsumerWidget {
  const Gateway({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPresent = ref.watch(userProfileNotifierProvider);

    return userPresent.when(
      data: (userData) {
        userData.debugLog(message: 'Gateway data State ');

        if (userData.isLeft()) {
          return const OnboardingScreens();
        } else if (userData.isRight()) {
          return const MainPage();
        }
        return const SizedBox.shrink();
      },
      error: (error, stack) {
        error.debugLog(message: 'Gateway error State');
        return const OnboardingScreens();
      },
      loading: () {
        'Gateway: loading state'.debugLog();
        return const Scaffold(body: Center(child: Loadingindicator()));
      },
    );
  }
}
