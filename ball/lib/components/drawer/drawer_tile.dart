import 'package:ball/state/models/drawer_options_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerTile extends ConsumerWidget {
  final DrawerOptionsData data;
  const DrawerTile({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // clipBehavior: Clip.antiAlias,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   color: Colors.white,
      //   boxShadow: const [
      //     BoxShadow(
      //       color: Color.fromARGB(40, 0, 0, 0),
      //       blurRadius: 4,
      //       offset: Offset(0, 2),
      //     ),
      //   ],
      // ),
      child: ListTile(
        isThreeLine: data.subtext != null,
        dense: true,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white,
        leading: Icon(data.icon, size: 16),
        title: Text(
          data.label,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        subtitle: data.subtext != null
            ? Text(
                data.subtext!,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              )
            : null,
        onTap: data.onTap,
      ),
    );
  }
}
