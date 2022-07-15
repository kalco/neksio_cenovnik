
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:neksio_cenovnik/screens/detail_page.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidget createState() {
    return _SearchWidget();
  }
}

class _SearchWidget extends State<SearchWidget> {
  var _searchview = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  String query = '';
  late List<CenovnikModel> filteredList = [];


  @override
  void initState() {
    // TODO: implement initState
    _searchview.addListener(() {
      if (_searchview.text.isNotEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          query = _searchview.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double searchHeight = ConstantWidget.getPercentSize(height, 38);
    double radius = ConstantWidget.getPercentSize(height, 18);

    return WillPopScope(
    child:Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                  color: primaryColor,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: (){
                              _requestPop();
                            },
                            child: const Icon(
                              LineIcons.angleLeft,
                              color: Colors.white,
                            ),
                          ),
                        )

                    ),


                    flex: 1,),
                  Container(
                    margin: EdgeInsets.all(
                        ConstantWidget.getScreenPercentSize(context, 2)),
                    padding: EdgeInsets.symmetric(
                        horizontal: ConstantWidget.getScreenPercentSize(
                            context, 1)),
                    height: searchHeight,
                    decoration: BoxDecoration(
                        color: cellColor,
                        borderRadius: BorderRadius.all(Radius.circular(
                            ConstantWidget.getPercentSize(
                                searchHeight, 18)))),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.search,
                            color: textColor,
                            size: ConstantWidget.getPercentSize(
                                (searchHeight / 1.3), 50)),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: (margin / 2)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize:
                                      ConstantWidget.getPercentSize(
                                          searchHeight, 30)),
                                  controller: _searchview,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                          ConstantWidget.getPercentSize(
                                              searchHeight, 30)),
                                      hintText: 'Внесете име на производ овде...'),
                                ),
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),
            StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snapshot) {
                List<CenovnikModel> cenovnikList = [];
                if (snapshot.hasData) {
                  final card = List<dynamic>.from((snapshot.data! as Event).snapshot.value);
                  for (var key in card) {
                    final next = Map<String, dynamic>.from(key);
                    CenovnikModel descriptionModel = CenovnikModel(
                      code: next['Code'].toString(),
                      group: next['Group'].toString(),
                      subgroup: next['Subgroup'].toString(),
                      brend: next['Brend'].toString(),
                      description: next['Description'].toString(),
                      warranty: next['warranty (days)'].toString(),
                      vat: next['Vat'].toString(),
                      stock: next['Stock'].toString(),
                      price: next['Price'].toString(),
                    );
                    cenovnikList.add(descriptionModel);
                  }
                }
                return query.isNotEmpty ? _performSearch(cenovnikList) : Container();
              },
            ),
          ],
        ) ,
      ),
    ),
     onWillPop: _requestPop);
  }

  Widget _performSearch(List<CenovnikModel> allProducts) {
    filteredList.clear();
    for (int i = 0; i < allProducts.length; i++) {
      var item = allProducts[i];

      if (item.description.contains(query.toUpperCase())) {
        filteredList.add(item);
      }
    }
    return _createFilteredList();
  }

  Widget _createFilteredList() {
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double radius = ConstantWidget.getPercentSize(height, 18);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double cellHeight = ConstantWidget.getWidthPercentSize(context, 35);
    return Flexible(
        child:ListView.builder(
          itemCount: filteredList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(filteredList[index]),));
              },
              child: Padding(
                padding:  EdgeInsets.only(top:margin,),
                child: Container(
                  height: cellHeight,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: margin,),
                  padding: EdgeInsets.symmetric(horizontal: (margin/1.7),),

                  decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(radius)),
                      border: Border.all(color: Colors.grey, width: 0.3)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: (margin/0.7),horizontal: (margin/2)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ConstantWidget.getCustomText(
                                      filteredList[index].description,
                                      textColor,2,
                                      TextAlign.left,
                                      FontWeight.bold,
                                      ConstantWidget.getPercentSize(
                                          cellHeight, 10)),
                                ),
                                Row(
                                  children: [
                                    getPriceCell(filteredList[index].price),
                                    getCatCell(filteredList[index].group),
                                  ],
                                ),
                                SizedBox(
                                  height: ConstantWidget.getPercentSize(
                                      cellHeight,5),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ) );
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  getPriceCell(String s) {
    double margin = ConstantWidget.getScreenPercentSize(context, 1);

    return Expanded(
      child: Row(
        children: [
          SizedBox(width: (margin)),
          Expanded(
            child: ConstantWidget.getCustomText(s, subTextColor,1, TextAlign.left,
                FontWeight.w600, ConstantWidget.getScreenPercentSize(context, 1.6)),
          ),
        ],
      ),
    );
  }

    getCatCell(String s) {
    double margin = ConstantWidget.getScreenPercentSize(context, 1);

    return Expanded(
      child: Row(
        children: [
          SizedBox(width: (margin)),
          Expanded(
            child: ConstantWidget.getCustomText(s, ConstantData.color3,1, TextAlign.left,
                FontWeight.w600, ConstantWidget.getScreenPercentSize(context, 1.6)),
          ),
        ],
      ),
    );
  }
}
