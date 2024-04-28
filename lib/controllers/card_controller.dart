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

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();

    await fireStore.collection(ordersCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().userName,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalCode': postalCodeController.text,
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
