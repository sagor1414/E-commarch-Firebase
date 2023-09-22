import 'package:srss_app/consts/consts.dart';

Widget homeButton({width, height, String? title, icon, onpress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.white.size(width, height).shadowSm.rounded.make().onTap(() {
    onpress();
  });
}
