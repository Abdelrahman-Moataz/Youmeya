import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/controllers/home_controller.dart';
import 'package:youmeya/view/history_screen/history_widget/notification.dart';
import '../../services/firestore_services.dart';
import '../service_screen/service_screen.dart';

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
                                  Image.asset(
                                    logo,
                                    height: h * 0.05,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Hello,",
                                        style: TextStyle(
                                          fontFamily: interThin,
                                        ),
                                      ),
                                      Text(
                                        "${data['name']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: interThin,
                                        ),
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                ],
                              ),
                              notificationWidget(h: h * 0.05),
                            ],
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Display dropdown menu
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Select Location',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: interThin,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        StreamBuilder(
                                            stream:
                                                FireStoreServices.getLocation(
                                                    currentUser!.uid),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            mainColor),
                                                  ),
                                                );
                                              } else {
                                                var data = snapshot.data!.docs;

                                                return Expanded(
                                                  child: ListView.builder(
                                                    itemCount:
                                                    data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final location =
                                                      data[index]['address'];
                                                      return ListTile(
                                                        title: Text(location),
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedLocation =
                                                                location;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            }),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: h * 0.06,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: mainColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Delivering to",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: medium,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      _selectedLocation ?? 'Select Location',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: medium,
                                        color: whiteColor,
                                      ),
                                    ),
                                    const Icon(Icons.location_pin,
                                        color: whiteColor, size: 18),
                                  ],
                                ),
                              ),
                            ),
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
                          const SizedBox(height: 5),
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
                            itemCount: 4,
                            // scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),

                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 130,
                            ),
                            itemBuilder: (context, index) {
                              return homeWidget(
                                onTap: () {
                                  Get.to(() => ServiceScreen(
                                        title: homeTitle[index],
                                      ));
                                },
                                h: h * 0.2,
                                w: w * 0.2,
                                title: homeTitle[index],
                                color: col[index],
                                img: images[index],
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
