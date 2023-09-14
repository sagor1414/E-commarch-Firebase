import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/services/firestore_services.dart';
import 'package:srss_app/widzet_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Favorite Item yet !"
                  .text
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: IconButton(
                                onPressed: () async {
                                  await firestore
                                      .collection(productsCollection)
                                      .doc(data[index].id)
                                      .set({
                                    'p_wishlist': FieldValue.arrayRemove(
                                        [currentUser!.uid])
                                  }, SetOptions(merge: true));
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: redColor,
                                )),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
