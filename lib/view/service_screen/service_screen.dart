import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/basket_screen/widgets/basket_widget.dart';
import 'package:youmeya/view/service_screen/widgets/card_of_items.dart';
import '../../controllers/card_controller.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import '../checkout_screen/checkout_screen.dart';
import '../history_screen/history_widget/notification.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.title});
  final String title;
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>
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

    var controller = Get.put(ProductController());

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
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  notificationWidget(h: h * 0.05),
                ],
              ),
              20.heightBox,
              SizedBox(
                height: h * 0.85,
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
                              stream: FireStoreServices.getSubCategoryProducts(
                                  "tops ${widget.title}"),
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
                                    child: "No Products available"
                                        .text
                                        .color(bottom)
                                        .make(),
                                  );
                                } else {
                                  //var data = snapshot.data!.docs;
                                  //controller.calculate(data);
                                  //controller.productSnapshot = data;

                                  return ListView(
                                    shrinkWrap: true,
                                    children: List.generate(
                                      snapshot.data!.docs.length,
                                      (index) => cardOfItems(
                                        img: snapshot.data!.docs[index]['img'],
                                        name: snapshot.data!.docs[index]
                                            ['name'],
                                        price:
                                            "${snapshot.data!.docs[index]['p_price']}  EGP",
                                        onTap: () {
                                          controller.addToCart(
                                            img: snapshot.data!.docs[index]
                                                ['img'],
                                            subSubCategory: snapshot.data!
                                                .docs[index]['subSubCategory'],
                                            subCategory: snapshot.data!
                                                .docs[index]['subCategory'],
                                            price: snapshot.data!.docs[index]
                                                ['p_price'],
                                            pPrice: snapshot.data!.docs[index]
                                                ['p_price'],
                                            name: snapshot.data!.docs[index]
                                                ['name'],
                                            category: snapshot.data!.docs[index]
                                                ['category'],
                                            context: context,
                                          );
                                          VxToast.show(context,
                                              msg: 'Item added to the Basket');
                                        },
                                        context1: context,
                                        context2: context,
                                      ),
                                    ),
                                  );
                                }
                              }),
                          StreamBuilder(
                              stream: FireStoreServices.getSubCategoryProducts(
                                  "bottoms ${widget.title}"),
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
                                    child: "No Products available"
                                        .text
                                        .color(bottom)
                                        .make(),
                                  );
                                } else {
                                  return ListView(
                                      shrinkWrap: true,
                                      children: List.generate(
                                        snapshot.data!.docs.length,
                                        (index) => cardOfItems(
                                          name: snapshot.data!.docs[index]
                                              ['name'],
                                          img: snapshot.data!.docs[index]
                                              ['img'],
                                          price:
                                              "${snapshot.data!.docs[index]['p_price']}  EGP",
                                          onTap: () {
                                            controller.addToCart(
                                              img: snapshot.data!.docs[index]
                                                  ['img'],
                                              subSubCategory:
                                                  snapshot.data!.docs[index]
                                                      ['subSubCategory'],
                                              subCategory: snapshot.data!
                                                  .docs[index]['subCategory'],
                                              price: snapshot.data!.docs[index]
                                                  ['p_price'],
                                              pPrice: snapshot.data!.docs[index]
                                                  ['p_price'],
                                              name: snapshot.data!.docs[index]
                                                  ['name'],
                                              category: snapshot.data!
                                                  .docs[index]['category'],
                                              context: context,
                                            );
                                            VxToast.show(context,
                                                msg:
                                                    'Item added to the Basket');
                                          },
                                          context1: context,
                                          context2: context,
                                        ),
                                      ));
                                }
                              }),
                          StreamBuilder(
                              stream: FireStoreServices.getSubCategoryProducts(
                                  "formal ${widget.title}"),
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
                                    child: "No Products available"
                                        .text
                                        .color(bottom)
                                        .make(),
                                  );
                                } else {
                                  return ListView(
                                      shrinkWrap: true,
                                      children: List.generate(
                                        snapshot.data!.docs.length,
                                        (index) => cardOfItems(
                                          name: snapshot.data!.docs[index]
                                              ['name'],
                                          img: snapshot.data!.docs[index]
                                              ['img'],
                                          price:
                                              "${snapshot.data!.docs[index]['p_price']}  EGP",
                                          onTap: () {
                                            controller.addToCart(
                                              subSubCategory:
                                                  snapshot.data!.docs[index]
                                                      ['subSubCategory'],
                                              subCategory: snapshot.data!
                                                  .docs[index]['subCategory'],
                                              price: snapshot.data!.docs[index]
                                                  ['p_price'],
                                              pPrice: snapshot.data!.docs[index]
                                                  ['p_price'],
                                              name: snapshot.data!.docs[index]
                                                  ['name'],
                                              category: snapshot.data!
                                                  .docs[index]['category'],
                                              context: context,
                                              img: snapshot.data!.docs[index]
                                                  ['img'],
                                            );
                                            VxToast.show(context,
                                                msg:
                                                    'Item added to the Basket');
                                          },
                                          context1: context,
                                          context2: context,
                                        ),
                                      ));
                                }
                              }),
                        ],
                      ),
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
