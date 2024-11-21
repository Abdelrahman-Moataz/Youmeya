import 'package:youmeya/consent/consent.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var userName = '';
  var phoneNumber = '';
  var location = {}.obs; // Change from List to Map

  var searchController = TextEditingController();



  getUserName() async {
    var n = await fireStore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    var f = await fireStore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['phone_number'];
      }
    });

    userName = n;
    phoneNumber = f;
  }




  // Other methods remain the same...
  Future<void> getUserLocation({String? address}) async {
    var snapshot = await fireStore
        .collection(locationCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .where('address', isEqualTo: address)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.single.data();
      var address = data['address'];
      var buildingNumber = data['buildingNumber'];
      var buildingName = data['buildingName'];
      var floorNumber = data['floorNumber'];

      // Storing the location data as a Map
      location.value = {
        'address': address,
        'buildingNumber': buildingNumber,
        'buildingName': buildingName,
        'floorNumber': floorNumber,
      };

      print('Location: ${location.value}');
    } else {
      print('No location data found for the user');
      location.value = {}; // Clear the location if not found
    }
  }



}
