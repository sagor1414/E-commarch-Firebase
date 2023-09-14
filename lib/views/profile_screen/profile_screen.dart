import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/auth_controller.dart';
import 'package:srss_app/controllers/profile_controller.dart';
import 'package:srss_app/services/firestore_services.dart';
import 'package:srss_app/views/auth_screen/login_screen.dart';
import 'package:srss_app/views/chat_screen/messageing_screen.dart';
import 'package:srss_app/views/profile_screen/components/details_cart.dart';
import 'package:srss_app/views/profile_screen/edit_profile.dart';
import 'package:srss_app/views/profile_screen/orders_screen/order_screen.dart';
import 'package:srss_app/views/profile_screen/wishlist_screen/wishlist_screen.dart';
import 'package:srss_app/widzet_common/bg_widget.dart';
import 'package:srss_app/widzet_common/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    //User section and logout section
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 20, bottom: 10),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                                  icProfile,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imageUrl'],
                                  width: 90,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          5.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}"
                                  .text
                                  .size(10)
                                  .fontFamily(regular)
                                  .white
                                  .make(),
                            ],
                          )),
                          //edit button
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                color: whiteColor,
                              )),
                              onPressed: () {
                                controller.nameController.text = data['name'];
                                Get.to(() => EditProfilescreen(data: data));
                              },
                              child: const Icon(Icons.edit))
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else {
                            var countData = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCardbutton(
                                    count: countData[0].toString(),
                                    title: "In your cart",
                                    width: context.screenWidth / 3.6),
                                detailsCardbutton(
                                    count: countData[1].toString(),
                                    title: "Your wishlist",
                                    width: context.screenWidth / 3.6),
                                detailsCardbutton(
                                    count: countData[2].toString(),
                                    title: "Your order",
                                    width: context.screenWidth / 3.6),
                              ],
                            ).box.color(redColor).make();
                          }
                        }),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     detailsCardbutton(
                    //         count: data['cart_count'],
                    //         title: "In your cart",
                    //         width: context.screenWidth / 3.6),
                    //     detailsCardbutton(
                    //         count: data['wishlist_count'],
                    //         title: "Your wishlist",
                    //         width: context.screenWidth / 3.6),
                    //     detailsCardbutton(
                    //         count: data['order_count'],
                    //         title: "Your order",
                    //         width: context.screenWidth / 3.6),
                    //   ],
                    // ).box.color(redColor).make(),
                    //Buttons section
                    ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: darkFontGrey,
                              );
                            },
                            itemCount: profileButtonsList.length,
                            itemBuilder: ((BuildContext context, index) {
                              return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const OrderScreen());

                                      break;
                                    case 1:
                                      Get.to(() => const WishlistScreen());
                                      break;
                                    case 2:
                                      Get.to(() => const MessagesScreen());
                                      break;
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonsList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            }))
                        .box
                        .white
                        .rounded
                        .shadow
                        .margin(const EdgeInsets.all(14))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                    20.heightBox,

                    ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: redColor,
                                padding: const EdgeInsets.all(18)),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child: const Text("Log Out"))
                        .box
                        .rounded
                        .shadow
                        .size(150, 55)
                        .make()
                  ],
                ),
              );
            }
          }),
    ));
  }
}
