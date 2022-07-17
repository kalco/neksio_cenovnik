import 'package:flutter/material.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';

class ConstantWidget {
  static double getPercentSize(double total, double percent) {
    return (total * percent) / 100;
  }

  static double largeTextSize = 28;

  static double getScreenPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.height * percent) / 100;
  }

  static double getWidthPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.width * percent) / 100;
  }

  static Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

    static Widget getSelectableText(String text, Color color, TextAlign textAlign,
      FontWeight fontWeight, double textSizes) {
    return SelectableText(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }

  static Widget getTextWidget(String text, Color color, TextAlign textAlign,
      FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }

  static Widget getDefaultTextFiledWidget(BuildContext context, String s,
      TextEditingController textEditingController) {
    double height = ConstantWidget.getScreenPercentSize(context, 8.5);

    double radius = ConstantWidget.getPercentSize(height, 20);
    double fontSize = ConstantWidget.getPercentSize(height, 25);

    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: TextField(
        maxLines: 1,
        controller: textEditingController,
        style: TextStyle(
            fontFamily: ConstantData.fontsFamily,
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: fontSize),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: ConstantWidget.getWidthPercentSize(context, 2)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: s,
            hintStyle: TextStyle(
                fontFamily: ConstantData.fontsFamily,
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: fontSize)),
      ),
    );
  }

  static Widget getButtonWidget(
      BuildContext context, String s, var color, Function function) {
    double height = ConstantWidget.getScreenPercentSize(context, 8.5);
    double radius = ConstantWidget.getPercentSize(height, 20);
    double fontSize = ConstantWidget.getPercentSize(height, 30);

    return InkWell(
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(
            vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
            child: getDefaultTextWidget(
                s, TextAlign.center, FontWeight.w500, fontSize, Colors.white)),
      ),
      onTap: () {
        function();
      },
    );
  }

  static Widget getDefaultTextWidget(String s, TextAlign textAlign,
      FontWeight fontWeight, double fontSize, var color) {
    return Text(
      s,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: ConstantData.fontsFamily,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color),
    );
  }
}
