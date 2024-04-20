import 'package:youmeya/consent/consent.dart';

Widget listOfItems({int? qnt, String? img, }){
  return Row(
    children: [
       Text("$qnt X"),
      5.widthBox,
      Image.network(img!),
      15.widthBox,
    ],
  );
}