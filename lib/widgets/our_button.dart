import 'package:youmeya/consent/consent.dart';


Widget ourButton({Color colour= mainColor  ,double width = double.infinity,required Function() onPress, required Color color, required Color textColor,required String? title}) {
  return
    SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: colour),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: color,
          padding: const EdgeInsets.all(10),
        ),
        onPressed: onPress,
        child: title?.text.color(textColor).fontFamily(medium).bold.make(),
      ),
    );
}
