import 'package:youmeya/consent/consent.dart';

Widget cardWidget({double? w, double? h, String? title, String? body}) {
  return Card(
      color: bottom,
      elevation: 0.3,
      child: Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.all(5),
        width: w,
        height: h,
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white),
                15.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: const TextStyle(color: whiteColor),
                    ),
                    Text(
                      "$body",
                      style: const TextStyle(color: whiteColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
}
