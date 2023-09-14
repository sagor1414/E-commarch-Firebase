import 'package:srss_app/consts/consts.dart';

class FirestoreServices {
  //Get users data
  static getUser(uid) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get product according to category

  static getProduct(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get cart product
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete cart document
  static deletedocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //Get all chat messages in a particular seller
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagescollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //Get all order

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //Get all wishlist
  static getWishlist() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  //Get all messages in a list
  static getAllMessage() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //Get profile cart wishlist order count
  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }
}
