import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDialogs {
  final String description;
  final String label;
  List<AppButtonComponent> actions;

  AppDialogs({
    required this.description,
    required this.label,
    required this.actions,
  });
}

extension Present on AppDialogs {
  Future<bool?> present(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (builder) {
        return AlertDialog.adaptive(
          buttonPadding: const EdgeInsets.all(8),
          
          title: label.isNotEmpty
              ? Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0D0018),
                  ),
                )
              : const SizedBox.shrink(),
          content: Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0D0018),
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
