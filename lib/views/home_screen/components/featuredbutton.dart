import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/views/Catagory_screen/category_details.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      ),
      10.heightBox,
      title!.text
          .fontFamily(semibold)
          .overflow(TextOverflow.ellipsis)
          .color(darkFontGrey)
          .make(),
    ],
  )
      .box
      .width(240)
      .margin(const EdgeInsets.symmetric(horizontal: 5))
      .white
      .roundedSM
      .outerShadowSm
      .padding(const EdgeInsets.all(4))
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
