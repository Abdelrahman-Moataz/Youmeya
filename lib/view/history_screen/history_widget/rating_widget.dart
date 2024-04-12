import 'package:youmeya/consent/consent.dart';

Widget ratingWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Rating",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: medium,
                        fontWeight: FontWeight.bold),
                  ),
                  20.heightBox,
                  Row(
                    children: [
                      Image.asset(
                        images[1],
                        height: 60,
                      ),
                      Column(
                        children: [
                          Text(
                            homeTitle[1],
                          ),
                          const Text(
                            "Order #92287157",
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("⭐⭐⭐⭐⭐"),
                  10.heightBox,
                  TextFormField()
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
