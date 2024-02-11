import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/product_controller.dart';
import 'package:srss_app/views/chat_screen/chat_screen.dart';
import 'package:srss_app/widzet_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  final dynamic data;
  final String title;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.resetvalues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetvalues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title.text.fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                    } else {
                      controller.addToWishlist(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //swiper section
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      //title and details
                      title.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        maxRating: 5,
                        count: 5,
                        size: 25,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      //chat with seller
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "${data['p_seller']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make(),
                              5.heightBox,
                              "In House Brands"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            ],
                          )),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ).onTap(() {
                              Get.to(
                                () => const ChatScreen(),
                                arguments: [
                                  data['p_seller'],
                                  data['vendor_id']
                                ],
                              );
                            }),
                          )
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      18.heightBox,
                      //color section
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color:".text.color(darkFontGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(int.parse(
                                              data['p_colors'][index]
                                                  .toString())))
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 6))
                                          .make()
                                          .onTap(() {
                                        controller.colorIndex.value = index;
                                      }),
                                      Visibility(
                                          visible: index ==
                                              controller.colorIndex.value,
                                          child: const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadow.make(),
                      //quantity row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity".text.color(darkFontGrey).make(),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(data['p_price']));
                                  },
                                  icon: const Icon(Icons.remove)),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                  onPressed: () {
                                    controller.increaseQuantity(
                                        int.parse(data['p_quantity']));
                                    controller.calculateTotalPrice(
                                        int.parse(data['p_price']));
                                  },
                                  icon: const Icon(Icons.add)),
                              "(${data['p_quantity']} abailable)"
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            ],
                          ),
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),

                      //total price
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total".text.color(darkFontGrey).make(),
                          ),
                          "${controller.totalPrice.value}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .size(16)
                              .fontFamily(bold)
                              .make()
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),
                      //descrioption
                      20.heightBox,
                      "Description"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),
                      //Button section
                      15.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemdetailsbutton.length,
                            (index) => ListTile(
                                  title: itemdetailsbutton[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                )),
                      ),
                      20.heightBox,
                      productsyoumaylike.text
                          .fontFamily(semibold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      //you may lise this product its from home page
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop i5 8gen"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$450"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 7))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(7))
                                      .make()),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ourButton(
                        color: redColor,
                        onPress: () {
                          if (controller.quantity.value > 0) {
                            controller.addToCart(
                                color: data['p_colors']
                                    [controller.colorIndex.value],
                                context: context,
                                vendorID: data['vendor_id'],
                                img: data['p_imgs'][0],
                                qty: controller.quantity.value,
                                sellername: data['p_seller'],
                                title: data['p_name'],
                                tprice: controller.totalPrice.value);
                            VxToast.show(context,
                                msg: "Added to cart sucessfully");
                          } else {
                            VxToast.show(context, msg: "Please add quantity");
                          }
                        },
                        textcolor: whiteColor,
                        title: "Add to cart"),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 8,
                  //   ),
                  //   height: 60,
                  //   width: MediaQuery.of(context).size.width / 2,
                  //   decoration:
                  //       BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  //   child: ourButton(
                  //       color: Colors.blue,
                  //       onPress: () {
                  //         // Get.to(() => const ShipingDetails());
                  //       },
                  //       textcolor: whiteColor,
                  //       title: "Buy Now"),
                  // ),
                ],
              ),
              8.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
