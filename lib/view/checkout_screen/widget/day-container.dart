import 'package:youmeya/consent/consent.dart';

Widget dayContainer({
  required Color color,
  required double width,
  required double height,
  required String? day,
  required String? date,
}) {

  return Padding(
    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    child: Container(
      width: width,
      height: height ,
      //width: w * 0.2,
      //height: h * 0.07,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day ?? "",
              style: const TextStyle(
                color: whiteColor,
              ),
            ),
            Text(
              date ?? "",
              style: const TextStyle(
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}