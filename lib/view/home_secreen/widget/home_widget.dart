import 'package:youmeya/consent/consent.dart';

Widget homeWidget(
    {Function()? onTap,
    String? title,
    String? img,
    double? h,
    double? w,
    Color? color}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          //color: color!,
          borderRadius: BorderRadius.circular(20),
          border: const Border(
            top: BorderSide(color: borderColor),
            bottom: BorderSide(color: borderColor),
            left: BorderSide(color: borderColor),
            right: BorderSide(color: borderColor),
          )),
      child: Stack(

        children: [
          Text(
            title!,
            style: const TextStyle(color: Colors.black, fontFamily: interThin),
          ),
          Image.asset(img!,fit: BoxFit.fill,width: w! * 2.0,),
        ],
      ),
    ),
  );
}
