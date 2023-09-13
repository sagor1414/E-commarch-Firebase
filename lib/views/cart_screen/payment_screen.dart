import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/cart_controller.dart';
import 'package:srss_app/views/home_screen/home.dart';
import 'package:srss_app/widzet_common/loading_indicator.dart';
import 'package:srss_app/widzet_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Chose a payment method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          width: context.screenWidth - 20,
          child: controller.placeingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethod[controller.paymentIndex.value],
                      totalAmount: controller.totalp.value,
                    );
                    await controller.clearCart();
                    // ignore: use_build_context_synchronously
                    VxToast.show(context, msg: "Order placed sucessfully");
                    Get.offAll(const Home());
                  },
                  color: redColor,
                  textcolor: whiteColor,
                  title: "Confirm Order",
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4)),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                    activeColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            bottom: 5,
                            right: 10,
                            child: paymentMethod[index]
                                .text
                                .color(bluecolor)
                                .size(10)
                                .fontFamily(semibold)
                                .make())
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
