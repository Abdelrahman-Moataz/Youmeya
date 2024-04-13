import 'package:youmeya/consent/consent.dart';

Widget dayContainer({Color? colorr,context1,context2,String? day, String? date}){
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return Container(
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
            color: Colors.black,

          ),
        ),
        Text(
          date!,
          style: const TextStyle(
            color: Colors.black,

          ),
        ),
      ],
    ),
  );
}