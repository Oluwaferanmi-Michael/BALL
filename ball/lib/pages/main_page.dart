import 'package:ball/components/floating_navbar_components/floating_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/floating_navbar_components/floating_nav_bar.dart';
import 'court_map/court_map_page.dart';
import 'game_list.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var index = useState(0);
    final controller = usePageController();
    const items = [
      // NavBarItem(icon: FeatherIcons.home, label: 'home'),
      // NavBarItem(icon: FeatherIcons.fileText, label: 'news'),
      NavBarItem(icon: FeatherIcons.box, label: 'games', route: GameList()),
      NavBarItem(
        icon: FeatherIcons.map,
        label: 'court map',
        route: CourtMapPage(),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              // Stats(),
              // Team(),
              GameList(),
              CourtMapPage(),
            ],
          ),
          Positioned(
            bottom: kBottomNavigationBarHeight * .2,
            child: FloatingNavComponent(
              currentIndex: index.value,
              onTap: (value) {
                index.value = value;

                controller.jumpToPage(index.value);
              },
              items: items,
            ),
          ),
        ],
      ),
    );
  }
}
