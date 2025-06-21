import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:ball/state/models/enums/enums.dart';

import 'package:ball/state/models/location_information.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';

class LocationInfoWidget extends HookConsumerWidget {
  const LocationInfoWidget({super.key, required this.locationInformation});

  final ValueNotifier<LocationInformation> locationInformation;

  // Image fetchImage() {
  //   if (locationInformation.value.image != null) {
  //     final url = locationInformation.value.image!;
  //     try {
  //       NetworkImage(
  //         url,
  //       ).headers?.debugLog(message: 'Fetching image from URL: $url');
  //       final image = Image.network(url, fit: BoxFit.cover);

  //       return image;
  //     } on () catch (e) {
  //       Image.asset(
  //         'assets/images/no_image.png',
  //         fit: BoxFit.cover,
  //       ).debugLog(message: 'Error loading image: $e');
  //     }
  //   }

  //   return Image.asset('assets/images/no_image.png', fit: BoxFit.cover);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hooks

    // final image = useState<Image?>(null);
    // useEffect(() {
    //   image.value = fetchImage();
    //   return null;
    // }, []);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          // color: Colors.greenAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      locationInformation.value.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        locationInformation.value.address,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      locationInformation.value.price.isEmpty
                          ? 'Free'
                          : locationInformation.value.price,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  AppButtonComponent(
                    onTap: () => MapsLauncher.launchQuery(
                      locationInformation.value.address,
                    ),
                    type: ButtonType.secondary,
                    icon: const Icon(Icons.directions_outlined, size: 18),
                    color: const Color(0xFFBEADFF),
                    label: 'Get Directions',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
