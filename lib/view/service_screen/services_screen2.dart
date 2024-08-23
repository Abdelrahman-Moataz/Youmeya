import 'package:youmeya/consent/consent.dart';

class ServicesScreen2 extends StatelessWidget {
  const ServicesScreen2({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
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
                const Text("step 1 of 3"),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontFamily: medium),
                ),
                const Divider(),

                const Text("How many hours do you need your professional to stay?",
                style: TextStyle(
                  fontFamily: interThin,
                  fontSize: 14,
                ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
