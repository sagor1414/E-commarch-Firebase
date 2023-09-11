import 'package:srss_app/consts/consts.dart';

Widget detailsCardbutton({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .rounded
      .height(70)
      .width(width)
      .padding(const EdgeInsets.all(4))
      .make();
}
