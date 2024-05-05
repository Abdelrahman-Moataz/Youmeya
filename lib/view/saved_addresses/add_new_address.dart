import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/saved_addresses/saved_addresses_screen.dart';

import '../../controllers/auth_controller.dart';

final _formKey = GlobalKey<FormState>(); // Add GlobalKey<FormState>
var controller = Get.put(AuthController());

class AddNewAdress extends StatelessWidget {
  const AddNewAdress({super.key});

  @override
  Widget build(BuildContext context) {


    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add new Address"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [

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
                ourButton(
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        controller.isLoading(true);
                        try {

                          controller.storeUserLocationData(
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
                          )
                              .then((value) {
                            VxToast.show(context, msg: "Saved successfully");
                            Get.offAll(() => const savedAddresses());
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
          ),
        ),
      ),
    );
  }
}
