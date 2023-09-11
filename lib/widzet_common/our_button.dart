import 'package:srss_app/consts/consts.dart';

Widget ourButton({onPress, color, textcolor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: const EdgeInsets.all(10)),
      onPressed: onPress,
      child: title!.text.color(textcolor).fontFamily(bold).make());
}
