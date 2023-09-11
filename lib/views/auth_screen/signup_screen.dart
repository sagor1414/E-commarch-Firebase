import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/auth_controller.dart';
import 'package:srss_app/views/auth_screen/login_screen.dart';
import 'package:srss_app/widzet_common/applogo_widget.dart';
import 'package:srss_app/widzet_common/bg_widget.dart';
import 'package:srss_app/widzet_common/coustom_textfield.dart';
import 'package:srss_app/widzet_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var passwordRetypecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            18.heightBox,
            Obx(
              () => Column(
                children: [
                  coustomtextfield(
                      hint: namehint,
                      title: name,
                      controller: namecontroller,
                      isPass: false),
                  10.heightBox,
                  coustomtextfield(
                      hint: emailhint,
                      title: email,
                      controller: emailcontroller,
                      isPass: false),
                  10.heightBox,
                  coustomtextfield(
                      hint: passwordhint,
                      title: password,
                      controller: passwordcontroller,
                      isPass: true),
                  10.heightBox,
                  coustomtextfield(
                      hint: passwordhint,
                      title: retypepass,
                      controller: passwordRetypecontroller,
                      isPass: true),
                  15.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: redColor,
                          value: isCheck,
                          onChanged: (newvalue) {
                            setState(() {
                              isCheck = newvalue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: termsandcondition,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: "& ",
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: privacypolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                        ])),
                      )
                    ],
                  ),
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: isCheck == true ? redColor : fontGrey,
                          title: signup,
                          textcolor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      name: namecontroller.text);
                                }).then((value) {
                                  VxToast.show(context, msg: signupsucess);
                                  Get.offAll(() => const LoginScreen());
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  //wrapping into gesture detector of valocity x
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      allreadyhaveacc.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(15))
                  .width(context.screenWidth - 60)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
