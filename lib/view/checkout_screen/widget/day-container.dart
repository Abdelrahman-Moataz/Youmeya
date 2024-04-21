import 'package:youmeya/consent/consent.dart';

Widget dayContainer(
    {Color? colorr, context1, context2, String? day, String? date, Function()? onTap}) {
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return Padding(
    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    child: GestureDetector(
      onTap:onTap,
      child: Container(
        width: w * 0.2,
        height: h * 0.07,
        decoration: BoxDecoration(
          color: colorr,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day!,
              style: const TextStyle(
                color: whiteColor,
              ),
            ),
            Text(
              date!,
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
