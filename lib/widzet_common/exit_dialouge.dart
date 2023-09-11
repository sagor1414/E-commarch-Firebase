import 'package:flutter/services.dart';
import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/widzet_common/our_button.dart';

Widget exitDialouge(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textcolor: whiteColor,
                title: "Yes"),
            ourButton(
                color: bluecolor,
                onPress: () {
                  navigator!.pop(context);
                },
                textcolor: whiteColor,
                title: "No"),
          ],
        ),
        40.heightBox
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(26)).rounded.make(),
  );
}
