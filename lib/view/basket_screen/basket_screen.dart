
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/basket_screen/widgets/basket_widget.dart';
import '../checkout_screen/checkout_screen.dart';
import '../history_screen/history_widget/notification.dart';
import '../saved_addresses/widgets/card_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
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

                          Column(
                            children: [
                              basketCard(
                                context1: context,
                                context2: context,
                              ),
                              5.heightBox,
                              basketCard(
                                context1: context,
                                context2: context,
                              ),
                              5.heightBox,
                              basketCard(
                                context1: context,
                                context2: context,
                              ),
                              5.heightBox,
                            ],
                          ),



                          const Text(
                            'Person',
                            style: TextStyle(fontSize: 32),
                          ),
                          Column(
                            children: [
                              basketCard(
                                context1: context,
                                context2: context,
                              ),
                              5.heightBox,
                              basketCard(
                                context1: context,
                                context2: context,
                              ),
                              5.heightBox,
                              basketCard(
                                context1: context,
                                context2: context,
                              ),
                              5.heightBox,
                            ],
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(onPressed: (){
                      Get.to(()=>CheckOut());
                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Go to Check out",style: TextStyle(color: whiteColor),),
                          Column(
                            children: [
                              Text("300 EGP",style: TextStyle(color: whiteColor),),
                              Text("Delevery Fees",style: TextStyle(fontSize: 9,color: whiteColor),),
                            ],
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor
                    ),),

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
