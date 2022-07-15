import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neksio_cenovnik/generated/l10n.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:neksio_cenovnik/screens/detail_page.dart';
import 'package:get_storage/get_storage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key, r}) : super(key: key);
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var favList = [];
  @override
  Widget build(BuildContext context) {
    final favStorage = GetStorage();
    double height = ConstantWidget.getScreenPercentSize(context, 8.5);
    double subHeight = ConstantWidget.getPercentSize(height, 60);
    if (favStorage.read('fav') != null) {
      favList = favStorage.read('fav');
    }

    return SafeArea(
      child: favList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: favList.length,
              itemBuilder: (context, i) {
                final model = CenovnikModel.fromJson(favList[i]);
                return InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(model),));
                  },
                  child: Container(
                    margin: EdgeInsets.all(
                        ConstantWidget.getScreenPercentSize(context, 2)),
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            ConstantWidget.getScreenPercentSize(context, 1.5)),
                    height: height,
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.all(Radius.circular(
                          ConstantWidget.getPercentSize(height, 15))),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 1),
                            blurRadius: 2.0)
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: ConstantWidget.getCustomText(
                                model.description,
                                textColor,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getPercentSize(height, 22))),
                        Container(
                          height: subHeight,
                          padding: EdgeInsets.symmetric(
                              horizontal: ConstantWidget.getScreenPercentSize(
                                  context, 1)),
                          margin: EdgeInsets.all(
                              ConstantWidget.getScreenPercentSize(context, 1)),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  ConstantWidget.getPercentSize(
                                      subHeight, 10)))),
                          child: InkWell(
                             
                                      onTap: () {
                                        setState(() {
                                          favList.remove(favList[i]);
                                          favStorage.write('fav', favList);
                                        });
                                      },
                                      child: const Icon(LineIcons.trash, color: Colors.white)
                                      
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ConstantWidget.getTextWidget(
                          S.of(context).noFavorite,
                          textColor,
                          TextAlign.center,
                          FontWeight.w100,
                          ConstantWidget.getPercentSize(subHeight, 35)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
