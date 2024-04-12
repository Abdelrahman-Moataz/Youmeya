import 'package:youmeya/consent/consent.dart';

Widget notificationWidget({double? h}) {
  return InkWell(
    onTap: () {
      Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    child: Column(
                      children: [
                        Image.asset(noNotification),
                        const SizedBox(height: 10),
                        const Text(
                          "No Notification",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: interThin,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "You don't have any notification",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        //Buttons
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    child: Image.asset(
      notification,
      height: h,
    ),
  );
}
