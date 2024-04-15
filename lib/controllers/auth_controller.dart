import 'dart:io';

import 'package:youmeya/consent/consent.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>(); // Add GlobalKey<FormState>

  ///text controller

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var languageController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  var nameController = TextEditingController();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  var moreDetailsController = TextEditingController();
  var buildingNameController = TextEditingController();
  var buildingNumberController = TextEditingController();
  var floorNumberController = TextEditingController();
  var flatNumberController = TextEditingController();

  ///login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  ///signup method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  ///storing data method
  storeUserData({password, email}) async {
    DocumentReference store =
        fireStore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': "name",
      'password': password,
      'email': email,
      'imageUrl': '',
      'phone_number': "",
      'id': currentUser!.uid,
    });
  }

  ///storing complete reg method

  storeUserCompleteData(
      {name,
      phoneNumber,
      address,
      buildingName,
      buildingNumber,
      floorNumber,
      flatNumber,
      moreDetails}) async {
    DocumentReference store =
        fireStore.collection(userCollection).doc(currentUser!.uid);
    store.update({
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
      'buildingName': buildingName,
      'buildingNumber': buildingNumber,
      'floorNumber': floorNumber,
      'flatNumber': flatNumber,
      'moreDetails': moreDetails,
    });
  }

  /// google signup method

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> storeUserDataToFirestore(
      UserCredential userCredential, File image) async {
    User user = userCredential.user!;

    // Upload image to Firebase Storage
    String imageURL = await uploadImageToStorage(image, user.uid);

    // Store user data including image URL in Firestore
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': imageURL,
      // Add more fields as needed
    });
  }

  Future<String> uploadImageToStorage(File imageFile, String userID) async {
    // Get a reference to the storage service
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('$userID.jpg');

    // Upload file to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(imageFile);

    // Await the upload completion and get the image URL
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageURL = await taskSnapshot.ref.getDownloadURL();

    return imageURL;
  }

  ///signOut method

  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
