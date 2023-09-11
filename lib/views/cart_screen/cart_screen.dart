import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/cart_controller.dart';
import 'package:srss_app/services/firestore_services.dart';
import 'package:srss_app/views/cart_screen/shiping_screen.dart';
import 'package:srss_app/widzet_common/loading_indicator.dart';
import 'package:srss_app/widzet_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          width: context.screenWidth - 20,
          child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => const ShipingDetails());
              },
              textcolor: whiteColor,
              title: "Continue to shipping"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shoping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty"
                      .text
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                    "${data[index]['img']}",
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']}(x${data[index]['qty']})"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .size(16)
                                          .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: IconButton(
                                      onPressed: () {
                                        FirestoreServices.deletedocument(
                                            data[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: redColor,
                                      )),
                                );
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalp.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightgolden)
                          .roundedSM
                          .make(),
                      // SizedBox(
                      //     width: context.screenWidth - 20,
                      //     child: ourButton(
                      //         color: redColor,
                      //         onPress: () {},
                      //         textcolor: whiteColor,
                      //         title: "Confirm Order")
                      //         )
                    ],
                  ),
                );
              }
            }));
  }
}
