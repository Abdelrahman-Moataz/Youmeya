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
  var location = [];

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




  Future<void> getUserLocation({String? address}) async {
    var snapshot = await fireStore
        .collection(locationCollection)
        .where('id', isEqualTo: currentUser!.uid)
    .where('address',isEqualTo: address)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.single.data();
      var address = data['address'];
      var buildingNumber = data['buildingNumber'];
      var buildingName = data['buildingName'];
      var floorNumber = data['floorNumber'];

      // Storing the location data in a variable
      location = <String, dynamic>{
        'address': address,
        'buildingNumber': buildingNumber,
        'buildingName': buildingName,
        'floorNumber': floorNumber,
      } as List ;

      // Optionally, print the extracted data
      print('Location: $location');
    } else {
      // Handle the case where no data is found for the user
      print('No location data found for the user');
      // You might want to return null or throw an exception here
      location = ['No location data found for the user'];
    }
  }



}
