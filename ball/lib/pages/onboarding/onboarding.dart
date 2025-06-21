import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:ball/pages/onboarding/onboarding_sign_up.dart';
import 'package:ball/state/models/enums/enums.dart';

import 'package:ball/state/models/splash_screen_data.dart';
import 'package:ball/state/models/user/user_profile.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/notifier/user_profile_notifier.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreens extends HookConsumerWidget {
  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    final items = [
      OnboardingData(
        imagePath: 'assets/images/png/Illustration - 1.png',
        title: 'Welcome to the Court!',
        subtitle:
            'Get ready to level up your game. Tap below to get started and tell us your name and favorite position! Let\'s play some ball!',
      ),
      OnboardingData(
        imagePath: 'assets/images/png/Illustration - 2.png',
        title: 'Unleash Your Potential with Project Bask',
        subtitle:
            'Our mission is simple: to connect basketball enthusiasts, streamline game organization, and elevate the community. Whether you\'re finding local courts, tracking your stats, or challenging friends, Project Bask is your ultimate companion for everything hoops.',
      ),
      OnboardingData.empty(),
    ];

    ValueNotifier<int> pageIndexState = useState(0);
    final nameController = useTextEditingController();
    final positionController = useTextEditingController();
    final roleController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12,
          children: [
            Flexible(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) => pageIndexState.value = value,
                itemBuilder: (context, index) {
                  if (items[index] == items.last) {
                    return SingleChildScrollView(
                      child: OnboardingScreenSignUp(
                        nameController: nameController,
                        positionController: positionController,
                        roleController: roleController,
                        onboardingData: items[index],
                      ),
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: Image.asset(
                            items[index].imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].title,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              items[index].subtitle,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                // fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: items.length,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: items.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Color(0xFF440381),
                      radius: 4,
                      activeDotColor: Color(0xFF51E5FF),
                    ),
                  ),
                  AppButtonComponent(
                    onTap: () async {
                      if (pageIndexState.value < items.length - 1) {
                        pageController.animateToPage(
                          pageIndexState.value + 1,
                          duration: const Duration(milliseconds: 5),
                          curve: Curves.easeInOut,
                        );
                        return;
                      }

                      if (nameController.value.text.isNotEmpty) {
                        final userProfile = UserProfile(
                          name: nameController.value.text,
                          position: positionController.value.text.position,
                          // role: roleController.value.text.position
                        );

                        userProfile.debugLog();

                        await ref
                            .watch(userProfileNotifierProvider.notifier)
                            .createUser(user: userProfile);
                      }

                      'please fill in your name'.debugLog();
                    },
                    type: pageIndexState.value < items.length - 1
                        ? ButtonType.secondary
                        : ButtonType.primary,
                    trailingIcon: const Icon(Icons.arrow_forward_rounded),
                    label: Text(
                      pageIndexState.value < items.length - 1
                          ? 'Next'
                          : 'Get Started',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
