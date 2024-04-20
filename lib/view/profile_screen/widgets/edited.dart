import 'package:youmeya/consent/consent.dart';

Widget profileEdite({Function()? onTap, String? title, String? name}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black, // border color
          width: 0.1, // border width
        ),
        color: const Color(0x0F000000)),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name!),
          Text(title!),
          const Icon(Icons.edit),
        ],
      ),
    ),
  );
}
