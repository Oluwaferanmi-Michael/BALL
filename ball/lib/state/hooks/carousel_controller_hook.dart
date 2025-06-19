import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

useCarouselController({int initialItem = 0}) {
  return use(_CarouselControllerHook(initialItem: initialItem));
}

class _CarouselControllerHook extends Hook<CarouselController> {
  final int initialItem;

  const _CarouselControllerHook({this.initialItem = 0});

  @override
  _CarouselControllerState createState() => _CarouselControllerState();
}

class _CarouselControllerState
    extends HookState<CarouselController, _CarouselControllerHook> {
  late CarouselController _carouselController;

  // @override
  // void initHook() {
    
  //   // Initialize the carousel controller with the provided parameters
  //   // This is where you would set up the carousel controller
  // }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
    // This is where you would clean up resources
  }

  @override
  CarouselController build(BuildContext context) {
    // This is where you would return the current state of the carousel controller
    return _carouselController = CarouselController(
      initialItem: hook.initialItem,
    );
  }
}
