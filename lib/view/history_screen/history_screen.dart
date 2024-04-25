import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/history_screen/history_widget/card_wdget.dart';
import 'package:youmeya/view/history_screen/history_widget/notification.dart';
import 'package:youmeya/view/order_details/order_details.dart';

import '../../services/firestore_services.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
                    "History",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  notificationWidget(h: h * 0.05),
                ],
              ),
              20.heightBox,
              SizedBox(
                height: h * 0.76,
                child: StreamBuilder(
                  stream: FireStoreServices.getAllOrders(currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(mainColor),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: "No order yet".text.color(bottom).make(),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return ListView(
                          children: List.generate(
                        data.length,
                        (index) => CardWidget(
                            date: data[index]['order_date'],
                            OrderNumber: data[index]['order_code'],
                            context1: context,
                            number: data[index]['orders'].length.toString(),
                            context2: context,
                            onTap: () {
                              Get.to(() => const OrderDetails());
                            }),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
