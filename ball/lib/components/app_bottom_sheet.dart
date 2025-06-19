import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomSheets {
  Widget ui;
  final String label;

  AppBottomSheets({required this.ui, required this.label});
}

extension Present on AppBottomSheets {
  Future<void> present(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: const Color(0xFFFFFDEF),
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsetsGeometry.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1,
            mainAxisSize: MainAxisSize.min,
            children: [
              label.isEmpty
                  ? Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0D0018),
                      ),
                    )
                  : const SizedBox.shrink(),
              Flexible(child: SingleChildScrollView(child: ui)),
            ],
          ),
        );
      },
    );
  }
}
