import 'package:youmeya/consent/consent.dart';

Widget cardOfItems({
  String? price,
  String? name,
  context1,
  context2,
  void Function()? onTap,
}) {
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;

  return Column(
    children: [
      SizedBox(
        height: h * 0.12,
        child: Card(
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(shirt),
                Text(name!),
                Text(price!),
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.shopping_basket,
                    color: bottom,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
