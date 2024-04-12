import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/history_screen/history_widget/rating_widget.dart';
import 'package:youmeya/view/order_details_screen/order_details_screen.dart';

Widget CardWidget({context1, context2}) {
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return SizedBox(
    height: h * 0.21,
    width: w,
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: w * 0.27,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: const Image(
                      image: AssetImage(ironOnly), fit: BoxFit.cover),
                ),
                (w * 0.05).widthBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dry Clean & Iron",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              fontFamily: interThin,
                              color: Colors.black),
                        ),
                        (h * 0.009).heightBox,
                        const Text("Completed",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: interThin,
                              fontWeight: FontWeight.normal,
                            )),
                        (h * 0.005).heightBox,
                        const Text(
                          "Order num: #123456",
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: interThin,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    (w * 0.03).widthBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: w * 0.2,
                          height: h * 0.05,
                          child: InkWell(
                            onTap: () {
                              Get.dialog(const DetailsScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: interThin,
                                  ),
                                ),
                                // Or Track if not completed
                              ),
                            ),
                          ),
                        ),
                        (h * 0.03).heightBox,
                        SizedBox(
                          width: w * 0.2,
                          height: h * 0.05,
                          child: InkWell(
                            onTap: () {
                              Get.dialog(ratingWidget());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  "Review",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: interThin,
                                  ),
                                ),
                                // Or Track if not completed
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Number Of Items: 2",
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: interThin,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "31 March 2024",
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: interThin,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
