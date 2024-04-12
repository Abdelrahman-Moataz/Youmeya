import 'package:youmeya/consent/consent.dart';

Widget profileBtn({Function()? onTap, String? title, IconData? icon}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: mainColor,
          foregroundColor: Colors.grey[200],
          child: Icon(icon),
        ),
        Text(title!),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
