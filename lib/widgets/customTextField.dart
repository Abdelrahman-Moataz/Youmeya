import 'package:youmeya/consent/consent.dart';

Widget customTextField(
    {int mLine = 1,
    String? title,
    String? hint,
    controller,
    isPass,
    String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(borderColor).fontFamily(medium).size(16).make(),
      5.heightBox,
      TextFormField(
        validator: validator,
        maxLines: mLine,
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: medium,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: whiteColor,
          filled: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: fontGrey,
          )),
        ),
      ),
      5.heightBox
    ],
  );
}
