import 'package:youmeya/consent/consent.dart';

import '../models/categories_model.dart';
import 'home_controller.dart';

class CartController extends GetxController {


  // text controller for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var reviewController = TextEditingController();
  var ratingReviewController = TextEditingController();
  var moreDetailsController = TextEditingController();
  var orderPaymentMethodController = TextEditingController();
  var deliveryTimeController = TextEditingController();



  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];
  var vendors = [];

  var placingOrder = false.obs;

  var totalP = 0.obs;



  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['price'].toString());
    }
  }

  // calculateItem(data, index) {
  //   totalP.value = 0;
  //   for (var i = 0; i < data[index]['price']; i++) {
  //     totalP.value = totalP.value + int.parse(data[i]['price'].toString());
  //   }
  // }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required date, required time, required more,
    required orderPaymentMethod, required totalAmount, required address}) async {
    placingOrder(true);
    await getProductDetails();

    // Get a reference to the orders collection
    CollectionReference ordersRef = fireStore.collection(ordersCollection);

    // Query to get the maximum order code
    QuerySnapshot querySnapshot = await ordersRef.orderBy('order_code', descending: true).limit(1).get();

    // Initialize order code with a default value
    int newOrderCode = 1;

    // If there are any documents, get the maximum order code, parse it to integer, and add 1
    if (querySnapshot.docs.isNotEmpty) {
      int maxOrderCode = int.parse(querySnapshot.docs.first.get('order_code'));
      newOrderCode = maxOrderCode + 1;
    }

    await ordersRef.doc().set({
      'order_code': newOrderCode.toString(), // Convert back to string after incrementing
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().userName,
      'order_by_email': currentUser!.email,
      'collection_id': ordersRef.doc().id,
      'order_by_address': address,
      'pickUp_time': time,
      'pickUp_date': date,
      'more_details': more,
      'order_review': "",
      'oder_rating': "",
      'order_by_phone': Get.find<HomeController>().phoneNumber,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });

    placingOrder(false);
  }



  getProductDetails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        //'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'added_by': productSnapshot[i]['added_by'],
        'name': productSnapshot[i]['name'],
        'Price': productSnapshot[i]['price'],
        'qty': productSnapshot[i]['quantity'],
        'category': productSnapshot[i]['category'],
        'sub_category': productSnapshot[i]['sub_category'],
        'title': productSnapshot[i]['subSubCategory'],
      });

    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      fireStore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

  updateOrderStatus({orderId, review, rating})async {
    await fireStore.collection(ordersCollection).doc(orderId).update({
      'order_review': review,
      'oder_rating': rating,
    });
    Get.back();
  }


  ///Course

  var productsMap = {}.obs;

  void addProductsToCard(CategoryModel categoryModel) {
    if (productsMap.containsKey(categoryModel.categories)) {
      productsMap[categoryModel.categories] += 1;
    } else {
      productsMap[categoryModel.categories] = 1;
    }
  }

  void removeProductsFromCard(CategoryModel categoryModel) {
    if (productsMap.containsKey(categoryModel.categories) &&
        productsMap[categoryModel.categories] == 1) {
      productsMap.removeWhere((key, value) => key == categoryModel.categories);
    } else {
      productsMap[categoryModel.categories] -= 1;
    }
  }

  void removeOneProductFromCard(CategoryModel categoryModel) {

    productsMap.removeWhere((key, value) => key == categoryModel.categories);
  }
  void clearAllProducts() {
    productsMap.clear();
  }

  get productSubTotal =>
      productsMap.entries.map((e) => e.key.price * e.value).toList();

  get Tottal => productsMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}
