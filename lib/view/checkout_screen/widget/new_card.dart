import 'package:youmeya/consent/consent.dart';

Widget newCard({context1, context2}) {
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return Column(
    children: [
      Container(
        height: h * 0.09,
        width: w,
        decoration: const BoxDecoration(
            color: mainColor,
            border: Border(
              top: BorderSide(color: borderColor),
              right: BorderSide(color: borderColor),
              left: BorderSide(color: borderColor),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Order details",
              style: TextStyle(
                  fontSize: 18, color: whiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Container(
        height: h * 0.09,
        width: w,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          border: Border(
            bottom: BorderSide(color: borderColor),
            right: BorderSide(color: borderColor),
            left: BorderSide(color: borderColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Service:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * 0.37,
                  ),
                  const Text(
                    "Dry Clean & Iron",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Number of items:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: w * 0.22,
                  ),
                  const Text("1 items",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
