import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/consent/strings.dart';
import 'package:youmeya/view/bite_screen/bite_screen.dart';

import '../bite_screen/system_bit/system-bit.dart';
import '../place_order/place_order.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: SizedBox(
        height: h * 0.99,
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 29,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.40,
                    width: w,
                    child: Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(serviesImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                  5.heightBox,

                  title!.text.size(20.0).make(),
                  5.heightBox,
                  Text("⭐⭐⭐⭐⭐",style: TextStyle(fontSize: 20),),
                  5.heightBox,
                  Text("Starts from 300EGP",style: TextStyle(fontSize: 15),),
                  5.heightBox,
                  Text("Description",style: TextStyle(fontSize: 18),),
                  5.heightBox,
                  Text(description,style: TextStyle(fontSize: 15),),

                  30.heightBox,

                  ourButton(
                      onPress: () {
                        Get.to(PlacingOrder(
                          title: title,
                        ));
                      },
                      color: mainColor,
                      textColor: fontColor,
                      title: "Book Now"),

                  10.heightBox,

                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
