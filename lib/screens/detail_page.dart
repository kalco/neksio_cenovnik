import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neksio_cenovnik/generated/l10n.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/models/models.dart';

class DetailScreen extends StatefulWidget {
  final CenovnikModel cenovnikModel;

  DetailScreen(this.cenovnikModel);

  @override
  _DetailScreen createState() {
    return _DetailScreen();
  }
}

class _DetailScreen extends State<DetailScreen> {
  final favStorage = GetStorage();
  var favList = [];
  int index = 0;
  bool productExist = false;
  late CenovnikModel model;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    ConstantData.setThemePosition();
    model = CenovnikModel(
        code: widget.cenovnikModel.code,
        group: widget.cenovnikModel.group,
        subgroup: widget.cenovnikModel.subgroup,
        brend: widget.cenovnikModel.brend,
        description: widget.cenovnikModel.description,
        warranty: widget.cenovnikModel.warranty,
        vat: widget.cenovnikModel.vat,
        stock: widget.cenovnikModel.stock,
        price: widget.cenovnikModel.price);

    if (favStorage.read('fav') != null) {
      favList = favStorage.read('fav');
      for (int i = 0; i < favList.length; i++) {
        final data = CenovnikModel.fromJson(favList[i]);
        if (data.code == model.code) {
          productExist = true;
        }
        index = i;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    var firstHeight = ConstantWidget.getScreenPercentSize(context, 5.5);
    var iconSize = ConstantWidget.getPercentSize(firstHeight, 62);
    var fontSize = ConstantWidget.getPercentSize(firstHeight, 34);
    var cellHeight = ConstantWidget.getScreenPercentSize(context, 4);
    var _crossAxisSpacing = 1;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var _aspectRatio = _width / cellHeight;
    double padding = ConstantWidget.getWidthPercentSize(context, 3);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: cellColor,
            centerTitle: false,
            elevation: 0,
            title: ConstantWidget.getTextWidget(
                widget.cenovnikModel.group,
                textColor,
                TextAlign.left,
                FontWeight.bold,
                ConstantWidget.getScreenPercentSize(context, 2.5)),
            leading: IconButton(
              icon: Icon(
                LineIcons.angleLeft,
                color: textColor,
              ),
              onPressed: _requestPop,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(margin),
                        child: ConstantWidget.getSelectableText(
                            widget.cenovnikModel.description,
                            textColor,
                            TextAlign.left,
                            FontWeight.bold,
                            ConstantWidget.getScreenPercentSize(context, 2.2)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: RichText(
                          text: TextSpan(
                            text: S.of(context).productCode,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 1.6),
                                color: subTextColor,
                                fontFamily: ConstantData.fontsFamily,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' #' + widget.cenovnikModel.code,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              const TextSpan(text: ' | '),
                              TextSpan(text: S.of(context).productCat + ' '),
                              TextSpan(
                                  text: widget.cenovnikModel.subgroup.isNotEmpty
                                      ? widget.cenovnikModel.subgroup
                                      : "N/A",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              const TextSpan(text: ' | '),
                              TextSpan(text: S.of(context).productBrend + ' '),
                              TextSpan(
                                  text: widget.cenovnikModel.brend.isNotEmpty
                                      ? widget.cenovnikModel.brend
                                      : "N/A",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: (margin * 1.5), horizontal: margin),
                        child: Row(
                          children: [
                            getProductCell(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: margin,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            getButton(
                                S.of(context).productPrice,
                                widget.cenovnikModel.price,
                                ConstantData.color1,
                                LineIcons.coins),
                            SizedBox(
                              width: padding,
                            ),
                            getButton(
                                S.of(context).productStock,
                                widget.cenovnikModel.stock,
                                widget.cenovnikModel.stock.length > 2
                                    ? ConstantData.color5
                                    : ConstantData.color4,
                                LineIcons.lineChart),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: margin,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            getButton(
                                S.of(context).productWarranty,
                                widget.cenovnikModel.warranty + " денови",
                                subTextColor,
                                LineIcons.alternateShield),
                            SizedBox(
                              width: padding,
                            ),
                            getButton(
                                S.of(context).productVat,
                                widget.cenovnikModel.vat + "%",
                                subTextColor,
                                LineIcons.percent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getProductCell() {
    double size = ConstantWidget.getScreenPercentSize(context, 5.5);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.5);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (productExist) {
              favList.removeAt(index);
              productExist = false;
            } else {
              favList.add(model.toJson());
              productExist = true;
            }
            favStorage.write('fav', favList);
          });
        },
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 0.3)),
          child: Center(
              child: productExist
                  ? Icon(LineIcons.heartAlt,
                      color: Colors.green,
                      size: ConstantWidget.getPercentSize(size, 50))
                  : Icon(
                      LineIcons.heart,
                      color: Colors.green,
                      size: ConstantWidget.getPercentSize(size, 50),
                    )),
        ),
      ),
    );
  }

  getButton(String s, String s1, Color color, var icon) {
    double height = ConstantWidget.getScreenPercentSize(context, 3);

    return Expanded(
        child: InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: cellColor,
            borderRadius: BorderRadius.all(Radius.circular(
                ConstantWidget.getScreenPercentSize(context, 0.8))),
            border: Border.all(color: Colors.grey, width: 0.3)),
        padding: EdgeInsets.symmetric(
            horizontal: ConstantWidget.getWidthPercentSize(context, 2),
            vertical: ConstantWidget.getScreenPercentSize(context, 0.6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: (height),
              color: primaryColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidget.getCustomText(
                    s,
                    textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w600,
                    ConstantWidget.getScreenPercentSize(context, 2)),
                const SizedBox(
                  height: 2,
                ),
                ConstantWidget.getCustomText(
                    s1,
                    color,
                    2,
                    TextAlign.start,
                    FontWeight.w600,
                    ConstantWidget.getScreenPercentSize(context, 1.8)),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
