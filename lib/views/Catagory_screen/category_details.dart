import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/product_controller.dart';
import 'package:srss_app/services/firestore_services.dart';
import 'package:srss_app/widzet_common/bg_widget.dart';
import 'package:srss_app/widzet_common/loading_indicator.dart';

import 'item_details.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.fontFamily(bold).white.make(),
            ),
            body: StreamBuilder(
                stream: FirestoreServices.getProduct(title),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child:
                          "No products found".text.color(darkFontGrey).make(),
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  controller.subcat.length,
                                  (index) => "${controller.subcat[index]}"
                                      .text
                                      .size(12)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .makeCentered()
                                      .box
                                      .roundedSM
                                      .white
                                      .size(120, 65)
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 5))
                                      .make()),
                            ),
                          ),
                          20.heightBox,
                          Expanded(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 250,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8),
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          data[index]['p_imgs'][0],
                                          width: 200,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "${data[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${data[index]['p_price']}"
                                            .numCurrency
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
                                            horizontal: 12))
                                        .roundedSM
                                        .outerShadowSm
                                        .padding(const EdgeInsets.all(7))
                                        .make()
                                        .onTap(() {
                                      controller.checkIfFav(data[index]);
                                      Get.to(() => ItemDetails(
                                            title: "${data[index]['p_name']}",
                                            data: data[index],
                                          ));
                                    });
                                  })))
                        ],
                      ),
                    );
                  }
                })));
  }
}
