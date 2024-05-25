import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/nav_bar/nav_bar.dart';

import '../../controllers/auth_controller.dart';

class CompleteLogin extends StatefulWidget {
  const CompleteLogin({super.key});

  @override
  State<CompleteLogin> createState() => _CompleteLoginState();
}

class _CompleteLoginState extends State<CompleteLogin> {



  @override
  final _formKey = GlobalKey<FormState>();
 // Add GlobalKey<FormState>
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    "Complete Registration"
                        .text
                        .fontFamily(medium)
                        .center
                        .black
                        .size(18)
                        .make(),
                    15.heightBox,
                    customTextField(
                      hint: "Enter your name",
                      title: "Your Name",
                      isPass: false,
                      controller: controller.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    customTextField(
                      hint: "+2012345678",
                      title: "Phone number",
                      isPass: false,
                      controller: controller.phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone number';
                        }
                        return null;
                      },
                    ),
                    customTextField(
                      hint: "Home",
                      title: "Address label",
                      isPass: false,
                      controller: controller.addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address label';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customTextField(
                            hint: "nasr",
                            title: "Building name",
                            isPass: false,
                            controller: controller.buildingNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address label';
                              }
                              return null;
                            },
                          ),
                        ),
                        10.widthBox,
                        Expanded(
                          child: customTextField(
                            hint: "12",
                            title: "Building number",
                            isPass: false,
                            controller: controller.buildingNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address label';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: customTextField(
                            hint: "15",
                            title: "Floor number",
                            isPass: false,
                            controller: controller.floorNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address label';
                              }
                              return null;
                            },
                          ),
                        ),
                        10.widthBox,
                        Expanded(
                          child: customTextField(
                            hint: "5",
                            title: "Flat number",
                            isPass: false,
                            controller: controller.flatNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address label';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    customTextField(
                      hint: "Address details",
                      title: "",
                      isPass: false,
                      controller: controller.moreDetailsController,
                      mLine: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address label';
                        }
                        return null;
                      },
                    ),
                    15.heightBox,
                    controller.isLoading(false)
                        ? const Padding(
                      padding: EdgeInsets.only(left: 150,right: 150),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(mainColor),
                      ),
                    )
                        :
                    ourButton(
                        onPress: () async{
                          controller.isLoading(true);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            try {

                              await controller.storeUserLocationData(
                                address: controller.addressController.text,
                                buildingName:
                                controller.buildingNameController.text,
                                buildingNumber: controller
                                    .buildingNumberController.text,
                                floorNumber:
                                controller.floorNumberController.text,
                                flatNumber:
                                controller.flatNumberController.text,
                                moreDetails:
                                controller.moreDetailsController.text,
                              );

                             await controller
                                  .storeUserCompleteData(

                                      name: controller.nameController.text,
                                      phoneNumber:
                                          controller.phoneNumberController.text)
                                  .then((value) {
                                VxToast.show(context, msg: loggedIn,showTime: 6000);
                                controller.addressController.clear();
                                controller.buildingNameController.clear();
                                controller.buildingNumberController.clear();
                                controller.floorNumberController.clear();
                                controller.flatNumberController.clear();
                                controller.moreDetailsController.clear();

                                controller.isLoading(false);
                                Get.offAll(() =>  NavBar(currentIndex: 0.obs,),transition: Transition.fade);
                              });
                            } catch (e) {
                              VxToast.show(context, msg: e.toString());
                            }
                          }
                        },
                        color: mainColor,
                        textColor: whiteColor,
                        title: "Save"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
