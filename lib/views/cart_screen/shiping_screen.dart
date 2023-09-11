import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/cart_controller.dart';
import 'package:srss_app/views/cart_screen/payment_screen.dart';
import 'package:srss_app/widzet_common/coustom_textfield.dart';
import 'package:srss_app/widzet_common/our_button.dart';

class ShipingDetails extends StatelessWidget {
  const ShipingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth - 20,
        child: ourButton(
          onPress: () {
            if (controller.phoneController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redColor,
          textcolor: whiteColor,
          title: "continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            coustomtextfield(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            coustomtextfield(
                hint: "City",
                isPass: false,
                title: "city",
                controller: controller.cityController),
            coustomtextfield(
                hint: "Thana",
                isPass: false,
                title: "Thana",
                controller: controller.stateController),
            coustomtextfield(
                hint: "Post Code",
                isPass: false,
                title: "Post code",
                controller: controller.postalcodeController),
            coustomtextfield(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
