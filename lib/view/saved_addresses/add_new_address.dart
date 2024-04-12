import 'package:youmeya/consent/consent.dart';

class AddNewAdress extends StatelessWidget {
  const AddNewAdress({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add new Adress"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: h * 0.9,
            child: ListView(
              children: [
                Column(
                  children: [
                    customTextField(
                      title: "Your name",
                      hint: "Mohamed",
                      isPass: false,
                    ),
                    customTextField(
                      title: "Phone number",
                      hint: "+2012345678",
                      isPass: false,
                    ),
                    customTextField(
                      title: "Address lable",
                      hint: "Home",
                      isPass: false,
                    ),
                    customTextField(
                      title: "Area",
                      hint: "Maadi",
                      isPass: false,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: w * 0.4,
                          child: customTextField(
                            title: "Area",
                            hint: "Maadi",
                            isPass: false,
                          ),
                        ),
                        30.widthBox,
                        SizedBox(
                          width: w * 0.4,
                          child: customTextField(
                            title: "Area",
                            hint: "Maadi",
                            isPass: false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: w * 0.4,
                          child: customTextField(
                            title: "Area",
                            hint: "Maadi",
                            isPass: false,
                          ),
                        ),
                        30.widthBox,
                        SizedBox(
                          width: w * 0.4,
                          child: customTextField(
                            title: "Area",
                            hint: "Maadi",
                            isPass: false,
                          ),
                        ),
                      ],
                    ),
                    customTextField(
                      mLine: 3,
                            title: "Area",
                            hint: "Maadi",
                            isPass: false,
                          ),
                          10.heightBox,
                ourButton(
                    onPress: () {},
                    color: mainColor,
                    textColor: whiteColor,
                    title: "Save"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
