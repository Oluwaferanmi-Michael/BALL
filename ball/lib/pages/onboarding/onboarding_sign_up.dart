
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/splash_screen_data.dart';
import 'package:ball/state/models/utils/ext.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingScreenSignUp extends HookConsumerWidget {
  final OnboardingData onboardingData;
  final TextEditingController nameController;
  final TextEditingController positionController;
  final TextEditingController roleController;
  const OnboardingScreenSignUp({required this.nameController, required this.positionController, required this.roleController, super.key, required this.onboardingData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isPlayer = useState(false);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            spacing: 24,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Let\'s get to know you',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text(
                        'Name',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54,
                      ),
                      labelStyle: const TextStyle(color: Colors.black54),
                      hintText: 'Name',
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'What role do you play',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // -------------------------------
                  DropdownMenu(
                    expandedInsets: EdgeInsets.zero,
                    helperText: 'Do you play, if not what else do you do?',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: roleController,
                    trailingIcon: const Icon(
                      FeatherIcons.chevronDown,
                      size: 16,
                    ),
                    selectedTrailingIcon: const Icon(
                      FeatherIcons.chevronUp,
                      size: 16,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      // focusColor: Colors.deepPurple,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.deepPurple,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.deepPurple,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // width: MediaQuery.sizeOf(context).width - 32,
                    onSelected: (newSelection) {
                      if (newSelection == Role.player) {
                        isPlayer.value = true;
                      }
                    },
                    dropdownMenuEntries: Role.values
                        .map(
                          (role) => DropdownMenuEntry(
                            value: role,
                            label: role.name,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.white,
                              ),
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(8),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  // -------------------------------

                  Visibility(
                    visible: isPlayer.value,
                    child: DropdownMenu(
                      expandedInsets: EdgeInsets.zero,
                      helperText: 'What Position do you play?',
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      controller: positionController,
                      trailingIcon: const Icon(
                        FeatherIcons.chevronDown,
                        size: 16,
                      ),
                      selectedTrailingIcon: const Icon(
                        FeatherIcons.chevronUp,
                        size: 16,
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        // focusColor: Colors.deepPurple,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // width: MediaQuery.sizeOf(context).width - 32,
                      onSelected: (newSelection) {
                        // ref
                        //     .watch(selectPriorityControllerProvider.notifier)
                        //     .selectPirority(
                        //       priorityLevel:
                        //           newSelection ??
                        //           TaskPriority.focusNow.toProperString(),
                        //     );
                      },
                      dropdownMenuEntries: GamePositions.values
                          .map(
                            (positions) => DropdownMenuEntry(
                              value: positions,
                              label: positions.positionToString(),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(8),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
