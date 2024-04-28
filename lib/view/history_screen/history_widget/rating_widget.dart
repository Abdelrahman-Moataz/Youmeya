import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/controllers/card_controller.dart';
import 'package:youmeya/widgets/customTextField.dart';

Widget ratingWidget({double? rating,String? orderNum, required Function() onTap}) {
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
                          Text(
                            "Order #$orderNum",
                          ),
                        ],
                      ),
                    ],
                  ),

                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                       Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      Get.put(CartController()).ratingReviewController.text = rating.toString()  ;
                    },
                  ),
                  10.heightBox,
                  customTextField(
                    controller: Get.put(CartController()).reviewController,
                    hint: "Write a review",
                    mLine: 3,
                    title: "Review",
                    isPass: false,
                  ),
                  10.heightBox,
                  ourButton(
                      onPress: onTap,
                      color: mainColor,
                      textColor: whiteColor,
                      title: "Submit")
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
