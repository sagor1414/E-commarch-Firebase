// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/profile_controller.dart';
import 'package:srss_app/views/home_screen/home.dart';
import 'package:srss_app/widzet_common/bg_widget.dart';
import 'package:srss_app/widzet_common/coustom_textfield.dart';
import 'package:srss_app/widzet_common/our_button.dart';

class EditProfilescreen extends StatelessWidget {
  final dynamic data;
  const EditProfilescreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image url and controller path is empty then show this
              data['imageUrl'] == '' && controller.profileImagepath.isEmpty
                  ? Image.asset(
                      icProfile,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  //if data is not empty but controller is empty
                  : data['imageUrl'] != '' &&
                          controller.profileImagepath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      //if both are empty
                      : Image.file(
                          File(controller.profileImagepath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textcolor: whiteColor,
                  title: "Change image"),
              const Divider(),

              coustomtextfield(
                controller: controller.nameController,
                hint: namehint,
                title: name,
                isPass: false,
              ),
              5.heightBox,
              coustomtextfield(
                controller: controller.oldpassController,
                hint: oldpasswordhint,
                title: oldpass,
                isPass: true,
              ),
              10.heightBox,
              coustomtextfield(
                controller: controller.newpassController,
                hint: passwordhint,
                title: newpassword,
                isPass: true,
              ),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 80,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isloading(true);

                            //if image is not selected
                            if (controller.profileImagepath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            //if old password math the database password
                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthpassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword:
                                      controller.newpassController.text);
                              await controller.updateProfileDocument(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text);
                              VxToast.show(context, msg: "Updated Complete");
                              Get.offAll(() => const Home());
                            } else if (controller
                                    .oldpassController.text.isEmptyOrNull &&
                                controller
                                    .newpassController.text.isEmptyOrNull) {
                              await controller.updateProfileDocument(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: data['password']);
                              VxToast.show(context, msg: "Updated Complete");
                              Get.offAll(() => const Home());
                            } else {
                              VxToast.show(context, msg: "wrong old password");
                              controller.isloading(false);
                            }
                          },
                          textcolor: whiteColor,
                          title: "save"),
                    ),
            ],
          )
              .box
              .white
              .shadow
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 15, right: 15))
              .make(),
        ),
      ),
    ));
  }
}
