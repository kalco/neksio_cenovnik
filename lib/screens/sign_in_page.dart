import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neksio_cenovnik/generated/l10n.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/helpers/show_snack.dart';
import 'package:neksio_cenovnik/helpers/size_config.dart';
import 'package:neksio_cenovnik/main.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() {
    return _SignInPage();
  }
}

class _SignInPage extends State<SignInPage> {
  TextEditingController userNameController = TextEditingController();
  bool userNameValidate = false, isUserNameValidate = false;

  Future<bool> _requestPop() {
    Future.delayed(const Duration(milliseconds: 200), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    ConstantData.setThemePosition();
  }

  

  bool validateTextField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        isUserNameValidate = true;
      });
      return false;
    }
    setState(() {
      isUserNameValidate = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double height = ConstantWidget.getScreenPercentSize(context, 18);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2.5)),
              child: ListView(
                children: [
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2),
                  ),
                  Center(
                    child: Image.asset(
                      ConstantData.assetImagesPath + "neksio-logo.png",
                      height: height,
                    ),
                  ),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2.5),
                  ),
                  ConstantWidget.getTextWidget(S.of(context).signIn, subTextColor, TextAlign.center,
                      FontWeight.bold, ConstantWidget.getScreenPercentSize(context, 2.2)),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2.5),
                  ),
                  ConstantWidget.getDefaultTextFiledWidget(context, S.of(context).yourName, userNameController),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 4),
                  ),
                  ConstantWidget.getButtonWidget(
                      context, S.of(context).signInButton, primaryColor, _onLogin),
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Future _onLogin() async {
    if (validateTextField(userNameController.text)) {
      try {
        final nameStorage = GetStorage();
        nameStorage.write('name', userNameController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title:'Нексио Ценовник'),
          ),
        );
      } on Exception catch (e) {
        SnackMessage.instance.showSnack(message: e.toString());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 5000),
          backgroundColor: ConstantData.errorColor,
          content: Text(S.of(context).emptyField, style: const TextStyle(color: Colors.white))));
    }
  }
}
