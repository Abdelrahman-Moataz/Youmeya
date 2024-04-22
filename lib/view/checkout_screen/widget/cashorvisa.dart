import 'package:youmeya/consent/consent.dart';

Widget cashOrVisa({
  context1,
  context2,
  String? img,
  String? title,
  Color? colur,
}) {
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      height: h * 0.06,
      width: w,
      decoration: BoxDecoration(
        color: colur, // Use colur parameter for the background color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2.0, color: colur!), // Use colur parameter for the border color
      ),
      child: Row(
        children: [
          Image.asset(img!),
          SizedBox(width: 10),
          Text(
            title!,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}


// Container(
// height: 50,
// width: MediaQuery.of(context).size.width,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Scaffold(),
// ),
// );
// },
// child: Container(
// height: 50,
// width: 50,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Text(
// 'Cash',
// style: TextStyle(
// color: Colors.black,
// fontSize: 20,
// ),
// ),
// ),
// ),
// ),
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Scaffold(),
// ),
// );
// },
// child: Container(
// height: 50,
// width: 50,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Text(
// 'Visa',
// style: TextStyle(
// color: Colors.black,
// fontSize: 20,
// ),
// ),
// ),
// ),
// ),
// ],
// ),
