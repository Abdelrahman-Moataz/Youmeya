import 'package:youmeya/consent/consent.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios)),
                    Text("About Youmeya", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("            "),
                  ],
                ),
                10.heightBox,
                Text("Welcome to YouMeya, your go-to solution "
                    "for all your ironing and dry cleaning needs. "
                    "We understand the hassle of keeping your clothes "
                    "crisp and clean, "
                    "which is why we've designed YouMeya to "
                    "make your life easier.",),
                10.heightBox,
                Text("Our Mission", style: TextStyle(fontWeight: FontWeight.bold),),
                10.heightBox,
                Text("At YouMeya, our mission is to provide you "
                    "with the most convenient and efficient "
                    "ironing and dry cleaning services. "
                    "We strive to deliver impeccable results while "
                    "saving you time and effort, "
                    "so you can focus on what truly matters.",),
                10.heightBox,
                Text("Why Choose YouMeya?", style: TextStyle(fontWeight: FontWeight.bold),),
                10.heightBox,
                Text("YouMeya combines advanced technology with "
                    "exceptional service to provide you with a "
                    "seamless experience. Whether you need a quick press "
                    "for a business meeting or a thorough cleaning for your "
                    "delicate garments,"
                    " YouMeya is here to help.",),
                10.heightBox,
                Text("Contact Us", style: TextStyle(fontWeight: FontWeight.bold),),
                10.heightBox,

                Text("Got questions or need assistance? Feel free to reach out to us:",),
                20.heightBox,
                Text("* Email: YoumeyaApp@outlook.com"),
                20.heightBox,
                Text("Thank you for choosing YouMeya. We look forward to serving you!",),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
