import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/history_screen/history_widget/rating_widget.dart';

import '../../order_status_screen/order_status_screen.dart';

Widget CardWidget({String? orderStatus,double? rating,required Function() onpress,String? OrderNumber,String? number,context1, context2, Timestamp? date,Function()? onTap}) {
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
                         Text(orderStatus!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: interThin,
                              fontWeight: FontWeight.normal,
                            )),
                        (h * 0.005).heightBox,
                         Text(
                          "Order num: #$OrderNumber",
                          style: const TextStyle(
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
                            onTap: onTap,
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
                              Get.dialog(
                                  ratingWidget(
                                      rating:rating,
                                      onTap:onpress ,
                                      orderNum: OrderNumber)
                              );
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
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Number Of Items: $number",
                    style:const  TextStyle(
                        fontSize: 10,
                        fontFamily: interThin,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${date!.toDate().day}/${date.toDate().month}/${date.toDate().year}  ${date.toDate().hour}:${date.toDate().minute} ${date.toDate().hour > 12 ? "PM" : "AM"}",
                    style: const TextStyle(
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
