import 'package:ball/components/drawer/drawer_tile.dart';
import 'package:ball/state/models/drawer_options_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerUIComponent extends ConsumerWidget {
  const DrawerUIComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerItems = [
      DrawerOptionsData(
        label: 'Send feedback',
        icon: FeatherIcons.feather,
        onTap: () {},
        subtext: 'Noticed, something? or want a feature? let us know!',
      ),
    ];

    return Container(
      // padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      height: double.infinity,
      decoration: BoxDecoration(
        color: Scaffold.of(context).widget.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListView.separated(
        itemBuilder: (context, index) => DrawerTile(data: drawerItems[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: drawerItems.length,
      ),
    );
  }
}
