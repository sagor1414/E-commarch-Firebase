import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/views/profile_screen/orders_screen/components/order_place_details.dart';
import 'package:srss_app/views/profile_screen/orders_screen/components/order_status.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.add_box_outlined,
                  title: "Order placed",
                  showDone: data['order_placed'] ?? false),
              orderStatus(
                  color: bluecolor,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed'] ?? false),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_repair,
                  title: "on delivery",
                  showDone: data['order_on_delivery'] ?? false),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all,
                  title: "deliverd",
                  showDone: data['order_delivered'] ?? false),
              const Divider(),
              10.heightBox,
              orderplaceDetails(
                  d1: data['order_code'],
                  d2: data['shipping_method'],
                  title1: "Order Code",
                  title2: "Shipping Method"),
              orderplaceDetails(
                  d1: intl.DateFormat()
                      .add_yMd()
                      .format(data['order_date'].toDate()),
                  d2: data['payment_method'],
                  title1: "Order Date",
                  title2: "Payment Method"),
              orderplaceDetails(
                  d1: "Unpaid",
                  d2: "Order placed",
                  title1: "Payment status",
                  title2: "Delivery Status"),
              10.heightBox,
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Ammount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              10.heightBox,
              "Ordered product"
                  .text
                  .fontFamily(semibold)
                  .size(16)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderplaceDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']}x",
                        d2: "Refundable",
                      ),
                      "Color"
                          .text
                          .fontFamily(semibold)
                          .make()
                          .box
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .make(),
                      5.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 30,
                          color:
                              Color(int.parse(data['orders'][index]['color'])),
                        ),
                      )
                    ],
                  ).box.padding(const EdgeInsets.symmetric(vertical: 8)).make();
                }).toList(),
              )
                  .box
                  .shadowMd
                  .margin(const EdgeInsets.only(bottom: 4))
                  .white
                  .make(),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Tax".text.size(16).fontFamily(semibold).make(),
                    "00".numCurrency.text.make()
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "shipping cost".text.size(16).fontFamily(semibold).make(),
                    "00".numCurrency.text.make()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Discount".text.size(16).fontFamily(semibold).make(),
                    "00".numCurrency.text.make()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total ammount ".text.size(16).fontFamily(semibold).make(),
                    "${data['total_amount']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .make()
                  ],
                ),
              ),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
