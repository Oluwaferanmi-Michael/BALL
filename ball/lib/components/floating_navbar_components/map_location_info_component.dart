import 'package:ball/shared/libraries.dart';
import 'package:ball/state/provider/map_marker_provider.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

class LocationInfoWidget extends HookConsumerWidget {
  const LocationInfoWidget({super.key});

  // final ValueNotifier<LocationInformation> locationInformation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(showLocaleInfoNotifierProvider.notifier);
    final locationInformation = ref.watch(locationInformationNotifierProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.deepPurple, width: 1.5),
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
                  // Text(
                  //   locationInformation.name.isNotEmpty
                  //       ? locationInformation.name
                  //       : 'There currently isn\'t any information on this court',
                  //   style: GoogleFonts.poppins(fontSize: 10),
                  // ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      locationInformation.address.isNotEmpty
                          ? locationInformation.address
                          : 'There currently isn\'t any information on this court',
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

                  child: Text(
                    locationInformation.price.isEmpty
                        ? 'Free'
                        : locationInformation.price,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    AppButtonComponent(
                      onTap: () =>
                          MapsLauncher.launchQuery(locationInformation.address),
                      type: ButtonType.secondary,
                      icon: const Icon(Icons.directions_outlined, size: 18),
                      color: const Color(0xFFBEADFF),
                      label: 'Get Directions',
                    ),

                    IconButton(
                      padding: EdgeInsets.zero,
                      style: ButtonStyle(
                        shadowColor: WidgetStateProperty.all(Colors.black45),
                      ),
                      onPressed: () => isVisible.hide(),
                      icon: const Icon(Icons.close, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
