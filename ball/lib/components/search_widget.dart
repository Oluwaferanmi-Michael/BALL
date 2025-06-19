import 'package:ball/state/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchChangeWidget extends HookWidget {
  SearchWidgetState state;
  double width;
  SearchChangeWidget({super.key, required this.state, required this.width});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final widthState = useState(width);
    final searchWidgetState = useState(state);

    switch (state) {
      case SearchWidgetState.icon:
        return GestureDetector(
          onTap: () {
            state = state == SearchWidgetState.icon
                ? SearchWidgetState.search
                : SearchWidgetState.search;
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(FeatherIcons.search, color: Colors.black),
          ),
        );
      case SearchWidgetState.search:
        GestureDetector(
          onTap: () {
            searchWidgetState.value =
                searchWidgetState.value == SearchWidgetState.icon
                ? SearchWidgetState.search
                : SearchWidgetState.icon;
            width = MediaQuery.of(context).size.width * 0.5;
          },
          child: const Icon(FeatherIcons.x, color: Colors.black),
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                state = state == SearchWidgetState.icon
                    ? SearchWidgetState.search
                    : SearchWidgetState.icon;
                widthState.value = 0;
              },
              child: const Icon(FeatherIcons.x, color: Colors.black),
            ),
          ],
        );
    }
  }
}
