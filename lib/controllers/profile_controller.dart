import 'dart:io';
import 'package:youmeya/consent/consent.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImPath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  ///textField

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var phoneNumberController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  ///upload profile image

  Future<void> uploadProfileImage() async {
    try {
      if (currentUser == null) {
        throw Exception("Current user is null. Cannot upload profile image.");
      }

      if (profileImPath.value == null || profileImPath.value.isEmpty) {
        throw Exception("Profile image path is empty. Cannot upload profile image.");
      }

      var fileName = basename(profileImPath.value);
      var destination = 'images/${currentUser!.uid}/$fileName';
      Reference ref = FirebaseStorage.instance.ref().child(destination);

      TaskSnapshot uploadTask = await ref.putFile(File(profileImPath.value));
      if (uploadTask.state == TaskState.success) {
        profileImageLink = await ref.getDownloadURL();
        print("Profile image uploaded successfully. Download URL: $profileImageLink");
      } else {
        throw Exception("Failed to upload profile image.");
      }
    } catch (e) {
      print("Error uploading profile image: $e");
    }
  }





  // uploadProfileImage() async {
  //   var fileName = basename(profileImPath.value);
  //   var destination = 'images/${currentUser!.uid}/$fileName';
  //   Reference ref = FirebaseStorage.instance.ref().child(destination);
  //   await ref.putFile(File(profileImPath.value));
  //   profileImageLink = await ref.getDownloadURL();
  // }

  updateProfileImage({imgUrl}) async {
    var store = fireStore.collection('users').doc(currentUser!.uid);
    await store.set({
      'imageUrl': imgUrl,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  updateProfile({phoneNumber}) async {
    var store = fireStore.collection('users').doc(currentUser!.uid);
    await store.set({
      'phone_number': phoneNumber,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  updateProfilePassword({password}) async {
    var store = fireStore.collection('users').doc(currentUser!.uid);
    await store.set({
      'password': password,
    }, SetOptions(merge: true));
    isLoading(false);
  }


  updateProfileName({name}) async {
    var store = fireStore.collection('users').doc(currentUser!.uid);
    await store.set({
      'name': name,
    }, SetOptions(merge: true));
    isLoading(false);
  }


  updateProfileEmail({email}) async {
    var store = fireStore.collection('users').doc(currentUser!.uid);
    await store.set({
      'email': email,
    }, SetOptions(merge: true));
    isLoading(false);
  }




  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}