import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/history_screen/history_widget/card_wdget.dart';
import 'package:youmeya/view/history_screen/history_widget/notification.dart';


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
              CardWidget(context1: context, context2: context),
            ],
          ),
        ),
      ),
    );
  }
}
