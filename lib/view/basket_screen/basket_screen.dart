import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/basket_screen/widgets/basket_widget.dart';
import '../../controllers/card_controller.dart';
import '../../services/firestore_services.dart';
import '../checkout_screen/checkout_screen.dart';
import '../history_screen/history_widget/notification.dart';


class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }


  int count0 = 1;
  int count1 = 1;
  int count2 = 1;
  int count3 = 1;
  int count4 = 1;
  int count5 = 1;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    var controller = Get.put(CartController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(""),
                  const Text(
                    "Basket",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  notificationWidget(h: h * 0.05),
                ],
              ),
              20.heightBox,
              SizedBox(
                height: h * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TabBar(
                      unselectedLabelColor: mainColor,
                      labelColor: whiteColor,
                      indicatorColor: mainColor,
                      indicator: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      tabs: const [
                        Tab(
                          text: 'Top',
                        ),
                        Tab(
                          text: 'Bottoms',
                        ),
                        Tab(
                          text: 'Formal',
                        )
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          StreamBuilder(
                              stream: FireStoreServices.getProducts("tops"),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(mainColor),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: "Cart is Empty"
                                        .text
                                        .color(fontColor)
                                        .make(),
                                  );
                                } else {

                                  var data = snapshot.data!.docs;
                                  controller.calculate(data);
                                  controller.productSnapshot = data;

                                  return Column(
                                    children: List.generate(
                                        data.length,
                                            (index) =>
                                                basketCard(
                                                  name: data[index]['name'],
                                                  price: "${data[index]['p_price']}  EGP",
                                                  total: "${int.parse(data[index]['p_price'].toString())} EGP",
                                                  onTap: () {
                                                    setState(() {
                                                      count0++;
                                                    });
                                                  },
                                                  counted: "$count0",
                                                  onTap1: () {
                                                    setState(() {
                                                      count0--;
                                                    });
                                                  },
                                                  context1: context,
                                                  context2: context,
                                                ),

                                    )
                                  );
                                }
                              }),
                          const Text(
                            'Person',
                            style: TextStyle(fontSize: 32),
                          ),
                          const Text(
                            'Persongg',
                            style: TextStyle(fontSize: 32),
                          ),

                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => CheckOut());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Go to Check out",
                            style: TextStyle(color: whiteColor),
                          ),
                          Column(
                            children: [
                               Text(
                                  "${controller.totalP.value}",
                                  style: TextStyle(color: whiteColor),
                                ),

                              Text(
                                "Delevery Fees",
                                style:
                                    TextStyle(fontSize: 9, color: whiteColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
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
}
