import 'package:youmeya/consent/consent.dart';

Widget cashOrVisa({context1,context2,String? img,String? title, Color? colur,String? title1}) {
  final w = MediaQuery.of(context1).size.width;
  final h = MediaQuery.of(context2).size.height;
  return Container(
    height: h * 0.05,
    width: w * 0.3,
    decoration: BoxDecoration(
      color: colur,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Image.asset(img!),
        Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),

      ],
    )
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
