import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/services/firestore_services.dart';
import 'package:srss_app/widzet_common/loading_indicator.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessage(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Messages yet !"
                  .text
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered();
            } else {
              return Container(
                color: redColor,
              );
            }
          }),
    );
  }
}
