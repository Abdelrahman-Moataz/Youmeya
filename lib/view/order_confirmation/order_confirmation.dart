import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/nav_bar/nav_bar.dart';

import '../history_screen/history_widget/notification.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const Text(
                  "Order Confirmation",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                notificationWidget(h: h * 0.05),
              ],
            ),

            SingleChildScrollView(
              reverse: true,
              child: SizedBox(
                height: h * 0.82,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    30.heightBox,
                    Image.asset(confirmation, height: h * 0.3),
                    30.heightBox,
                    const Center(
                      child: Text(
                        "Your Order Is Placed!",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "#12345678",
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "You can track your order from the \nhistory screen or click the below button",
                        style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                    35.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: ourButton(
                        width: w * 0.1,
                          onPress: (){
                            Get.to(()=>const NavBar());
                          } ,
                          color: blueBottom,
                          textColor: whiteColor,
                          title: "Track My Order"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
