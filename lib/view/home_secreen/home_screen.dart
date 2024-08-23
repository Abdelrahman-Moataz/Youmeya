import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/controllers/home_controller.dart';
import 'package:youmeya/view/history_screen/history_widget/notification.dart';
import '../../services/firestore_services.dart';
import '../service_screen/service_screen.dart';
import '../service_screen/services_screen2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = HomeController();
  final List<String> _locations = [];

  final userController = Get.find<HomeController>();

  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: h * 0.99,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: StreamBuilder(
              stream: FireStoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(mainColor),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs[0];
                  return ListView(
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [

                                 // const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                        "👋 Hello, ${data['name']}",
                                        style: const TextStyle(
                                          fontFamily: interThin,
                                          fontSize: 23.0
                                        ),
                                      ),

                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                logo,
                                height: h * 0.08,
                                color: mainColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Container(
                            height: h * 0.28,
                            width: w,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(banner),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                mark,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: medium,
                                  color: mainColor,
                                ),
                              ),
                              Text(
                                explore,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: interThin,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            // scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),

                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 120,
                            ),
                            itemBuilder: (context, index) {
                              return homeWidget(
                                onTap: () {
                                  Get.to(() => ServicesScreen2(
                                        title: homeTitle[index],
                                      ));
                                },
                                h: h * 0.4,
                                w: w * 0.4,
                                title: homeTitle[index],
                                //color: col[index],
                                img: servicess[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
