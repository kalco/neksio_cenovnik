import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:neksio_cenovnik/helpers/size_config.dart';
import 'package:neksio_cenovnik/util/pref_data.dart';

Color cellColor = "#EEEEEE".toColor();
Color primaryColor = "#1C5998".toColor();
Color bgColor = "#FAFAFA".toColor();
Color textColor = "#31364C".toColor();
Color hightLightColor = "#FE9870".toColor();
Color subTextColor = Colors.grey.shade600;
Color subPrimaryColor = "#084043".toColor();
Color defPrimaryColor = Colors.orange;
Color defBgColor = Colors.grey.shade200;

class ConstantData {
  static const double padding = 20;
  static const double avatarRadius = 40;

  static String fontsFamily = 'Montserrat';
  static String assetImagesPath = 'assets/images/';

  static Color color1 = "#E46756".toColor();
  static Color color2 = "#E4BC39".toColor();
  static Color color3 = "#175AAE".toColor();
  static Color color4 = "#1BA454".toColor();
  static Color color5 = "#721FA2".toColor();

  static Color defColor = "#12153D".toColor();
  static Color errorColor = "#D6283D".toColor();

  static double font15Px = SizeConfig.safeBlockVertical! / 0.6;

  static double font12Px = SizeConfig.safeBlockVertical! / 0.75;

  static double font18Px = SizeConfig.safeBlockVertical! / 0.5;
  static double font20Px = SizeConfig.safeBlockVertical! / 0.58;
  static double font22Px = SizeConfig.safeBlockVertical! / 0.4;
  static double font25Px = SizeConfig.safeBlockVertical! / 0.3;

  static setThemePosition() async {
    int themMode = await PrefData.getThemeMode();

    if (themMode == 1) {
      textColor = Colors.white;
      bgColor = "#13151B".toColor();
      cellColor = "#1F1F1F".toColor();
      defBgColor = "#050708".toColor();
      subTextColor = Colors.white70;
    } else {
      textColor = "#31364C".toColor();
      bgColor = "#FAFAFA".toColor();
      cellColor = "#ffffff".toColor();
      defBgColor = Colors.grey.shade200;
      subTextColor = Colors.grey.shade600;
    }
  }

}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

 changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}
