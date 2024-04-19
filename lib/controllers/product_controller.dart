import 'package:youmeya/consent/consent.dart';
import 'package:flutter/services.dart';
import '../models/categories_model.dart';


class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isLoading = false.obs;

  var subCat = [];

  var isFav = false.obs;

  getSubCategories(title)async {
    subCat.clear();
     var data = await rootBundle.loadString("lib/services/category_model.json");
     var decoded = categoryModelFromJson(data);
     var s = decoded.categories.where((element) => element.name == title).toList();

     for(var e in s[0].subcategory){
       subCat.add(e);
     }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculatingTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }


  Future<void> addToCart({
    required String subCategory,
    required String price,
    required String pPrice,
    required String name,
    required BuildContext context,
    required String category,
    required String subSubCategory,
  }) async {
    final userCartRef = FirebaseFirestore.instance
        .collection(cartCollection)
        .where('added_by', isEqualTo: currentUser!.uid);

    // Check for existing cart item for the same user and product
    final matchingItems = await userCartRef.where('name', isEqualTo: name).get();

    // Handle existing item: update quantity and total price
    if (matchingItems.docs.isNotEmpty) {
      final existingItem = matchingItems.docs.first;
      final existingQuantity = existingItem.get('quantity')?.toInt() ?? 1;
      final existingPrice = int.tryParse(existingItem.get('price')!.toString()) ?? 0.0; // Handle potential parsing errors

      final int newTotalPrice = int.parse(price) ?? 0; // Handle potential parsing errors
      final updatedTotalPrice = (existingQuantity + 1) * newTotalPrice;

      await existingItem.reference.update({
        'quantity': existingQuantity + 1,
        'price': updatedTotalPrice.toString(), // Convert back to string for Firestore
      }).catchError((error) {
        VxToast.show(context, msg: 'Error updating cart item: $error');
      });
      return; // No need to add a new document if item exists
    }

    // Create a new cart item document if no existing item
    await FirebaseFirestore.instance
        .collection(cartCollection)
        .doc()
        .set({
      'category': category,
      'sub_category': subCategory,
      'subSubCategory': subSubCategory,
      'price': price, // Assuming price is already a valid string representation of a double
      'p_price': pPrice,
      'name': name,
      'quantity': 1,
      'added_by': currentUser!.uid,
    })
        .catchError((error) {
      VxToast.show(context, msg: 'Error adding item to cart: $error');
    });
  }


//increase The Item
  Future<void> increaseTheItem({
    //required String subCategory,
    required String price,
    required String name,
    required BuildContext context,
    //required String category,
  }) async {
    final userCartRef = FirebaseFirestore.instance
        .collection(cartCollection)
        .where('added_by', isEqualTo: currentUser!.uid);



    // Check for existing cart item for the same user and product
    final matchingItems = await userCartRef.where('name', isEqualTo: name).get();

    // Handle existing item: update quantity and total price
    if (matchingItems.docs.isNotEmpty) {
      final existingItem = matchingItems.docs.first;
      final existingQuantity = existingItem.get('quantity')?.toInt() ?? 1;
      final existingPrice = int.tryParse(existingItem.get('p_price')!.toString()) ?? 0.0; // Handle potential parsing errors

      final int newTotalPrice = int.parse(price) ?? 0; // Handle potential parsing errors
      final updatedTotalPrice = (existingQuantity + 1) * newTotalPrice;

      await existingItem.reference.update({
        'quantity': existingQuantity + 1,
        'price': updatedTotalPrice.toString(), // Convert back to string for Firestore
      }).catchError((error) {
        VxToast.show(context, msg: 'Error updating cart item: $error');
      });
      return; // No need to add a new document if item exists
    }

  }


  // decrease the items
  Future<void> decreaseTheItem({
    //required String subCategory,
    required String price,
    required String name,
    required BuildContext context,
    //required String category,
  }) async {
    final userCartRef = FirebaseFirestore.instance
        .collection(cartCollection)
        .where('added_by', isEqualTo: currentUser!.uid);



    // Check for existing cart item for the same user and product
    final matchingItems = await userCartRef.where('name', isEqualTo: name).get();

    // Handle existing item: update quantity and total price
    if (matchingItems.docs.isNotEmpty) {
      final existingItem = matchingItems.docs.first;
      final existingQuantity = existingItem.get('quantity')?.toInt() ?? 1;
      final existingPrice = int.tryParse(existingItem.get('p_price')!.toString()) ?? 0.0; // Handle potential parsing errors

      final int newTotalPrice = int.parse(price) ?? 0; // Handle potential parsing errors
      final updatedTotalPrice = (existingQuantity - 1) * newTotalPrice;

      await existingItem.reference.update({
        'quantity': existingQuantity - 1,
        'price': updatedTotalPrice.toString(), // Convert back to string for Firestore
      }).catchError((error) {
        VxToast.show(context, msg: 'Error updating cart item: $error');
      });
      return; // No need to add a new document if item exists
    }

  }




  // addToCart(
  //     {subCategory, price, name, context,category}) async {
  //   await fireStore.collection(cartCollection).doc().set({
  //     'category': category,
  //     'sub_category': subCategory,
  //     'price': price,
  //     'name': name,
  //     'added_by': currentUser!.uid,
  //   }).catchError((error) {
  //     VxToast.show(context, msg: error.toString());
  //   });
  // }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await fireStore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishList");
  }

  removeFromWishList(docId, context) async {
    await fireStore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishList");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].cotains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
