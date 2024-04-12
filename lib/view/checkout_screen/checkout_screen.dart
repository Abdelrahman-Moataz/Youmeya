import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/checkout_screen/widget/new_card.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    bool light = true;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: w,
          height: h * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text("Checkout"),
                  const Text("        "),
                ],
              ),
              10.heightBox,
              newCard(context1: context, context2: context),
              10.heightBox,
              newCard(context1: context, context2: context),
              10.heightBox,
              customTextField(mLine: 3, title: "", hint: "Note", isPass: false),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Request A call back"),
                  Switch(
                    // This bool value toggles the switch.
                    value: light,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                ],
              ),
              10.heightBox,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    ourButton(
                        onPress: () {},
                        color: Color(0xffFFDD61),
                        textColor: whiteColor,
                        title: "Apply")
                  ],
                ),
              ),
              10.heightBox,
              ourButton(
                  onPress: () {},
                  color: mainColor,
                  textColor: whiteColor,
                  title: "PLACE ORDER")
            ]),
          ),
        ),
      ),
    );
  }
}
