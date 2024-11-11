import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification_app/controller/phone_auth_controller.dart';

class PhoneAuthScreen extends StatelessWidget {
  // to use controller we need to create an instance of that controller
  // here, before the build method
  PhoneAuthController controller = Get.put(PhoneAuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Phone Auth"),
          centerTitle: true,
          elevation: 0,
        ),
        // we will wrap body widget with get builder to manage the state
        // using controller
        body: GetBuilder<PhoneAuthController>(
          builder: (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "71721021", labelText: "Phone Number"),

                    // lets add validation
                    validator: (String? number) {
                      if (number!.isEmpty) {
                        return "Enter Phone Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: controller.isCodeSent,
                    child: TextFormField(
                      controller: controller
                          .codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                          hintText: "123456",
                          labelText: "Code"),

                      // lets add validation
                      validator: (String? code) {
                        if (code!.isEmpty) {
                          return "Enter Code";
                        } else if (code.length < 6) {
                          return "Code should be of length 6";
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {

                                controller.sendSMS();
                                controller.showInvisibleWidgets();
                              }
                            },
                            child: const Text('Submit'))),
                  ),
                  Visibility(
                    visible: controller.isCodeSent,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!
                                  .validate()) {

                                controller.verifyOTP();
                              }
                            },
                            child: const Text('Verify'))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}