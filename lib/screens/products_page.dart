import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neksio_cenovnik/generated/l10n.dart';
import 'package:neksio_cenovnik/helpers/constant_data.dart';
import 'package:neksio_cenovnik/helpers/constant_widget.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:neksio_cenovnik/screens/detail_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key, required this.groupKey}) : super(key: key);
  final String groupKey;

  @override
  State<ProductsPage> createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {

  final databaseReference = FirebaseDatabase.instance.reference();
  var _searchview = TextEditingController();
  String query = '';
  late List<CenovnikModel> groupDeleteDublicate;
  late List<CenovnikModel> filteredList = [];
  List<CenovnikModel> getDeleteDuplicate(List<CenovnikModel> l) {
    List<CenovnikModel> del = [];
    for (var e in l) {
      if (e.group == widget.groupKey &&
          e.description.contains(query.toUpperCase())) {
        del.add(e);
      }
    }
    return del;
  }

  @override
  void initState() {
    super.initState();
    ConstantData.setThemePosition();
    setState(() {});

    //search for products in a specific category
    _searchview.addListener(() {
      if (_searchview.text.isNotEmpty) {
        setState(() {
          query = _searchview.text;
        });
      }
    });
  }

  Future searchDescription(String q) async {
    final getDescription = groupDeleteDublicate
        .where((element) => element.description.contains(q.toUpperCase()))
        .toList();
    if (!mounted) return;
    setState(() {
      query = q;
      groupDeleteDublicate = getDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(primaryColor);
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double radius = ConstantWidget.getPercentSize(height, 18);
    double searchHeight = ConstantWidget.getPercentSize(height, 38);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double cellHeight = ConstantWidget.getWidthPercentSize(context, 35);

    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: bgColor,
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
               child:
               StreamBuilder(
                    stream: databaseReference.onValue,
                    builder: (context, snapshot) {
                      List<CenovnikModel> group = [];
                      if (snapshot.hasData) {
                        final card = List<dynamic>.from((snapshot.data! as Event).snapshot.value);
                        for (var key in card) {
                          final json = Map<String, dynamic>.from(key);
                          CenovnikModel descriptionModel = CenovnikModel(
                            code: json['Code'].toString(),
                            group: json['Group'].toString(),
                            subgroup: json['Subgroup'].toString(),
                            brend: json['Brend'].toString(),
                            description: json['Description'].toString(),
                            warranty: json['warranty (days)'].toString(),
                            vat: json['Vat'].toString(),
                            stock: json['Stock'].toString(),
                            price: json['Price'].toString(),
                          );
                          group.add(descriptionModel);
                        }
                      }
                      groupDeleteDublicate = getDeleteDuplicate(group);
                      return group.isNotEmpty
                      ? Column(
                        children: [
                          Expanded(
                            flex: 3,
                              child:Container(
                                height: height,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    ),
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
                                    Expanded(
                                      flex: 1,
                                        child:Container(
                                          margin: EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2)),
                                          padding: EdgeInsets.symmetric(horizontal: ConstantWidget.getScreenPercentSize(
                                                  context, 1)),
                                          height: searchHeight,
                                          decoration: BoxDecoration(
                                              color: cellColor,
                                              borderRadius: BorderRadius.all(Radius.circular(
                                                  ConstantWidget.getPercentSize(
                                                      searchHeight, 18)))),
                                          child: Row(
                                            children: [
                                              Icon(LineIcons.search,
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
                                                            hintText: S
                                                                .of(context)
                                                                .searchProductPlaceholder),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          ),
                                        ) ),
                                  ],
                                ),

                              ), ),
                          query.isNotEmpty ? _performSearch(groupDeleteDublicate) :
                          Expanded(
                            flex: 10,
                              child:ListView.builder(
                                itemCount: groupDeleteDublicate.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(groupDeleteDublicate[index]),));
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
                                                            groupDeleteDublicate[index].description,
                                                            textColor,2,
                                                            TextAlign.left,
                                                            FontWeight.bold,
                                                            ConstantWidget.getPercentSize(
                                                                cellHeight, 10)),
                                                      ),
                                                      Row(
                                                        children: [
                                                          getPriceCell(groupDeleteDublicate[index].price),
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
                              ) )
                        ],
                      )
                      : const Center(child: CircularProgressIndicator());
              	  },
                  ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getProductCell(var icon, String s, var color) {
    double size = ConstantWidget.getScreenPercentSize(context, 4);
    double margin = ConstantWidget.getScreenPercentSize(context, 1);

    return Expanded(
      child: Row(
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 0.3)),
            child: Center(
              child: Icon(icon,
                  color: color, size: ConstantWidget.getPercentSize(size, 50)),
            ),
          ),
          SizedBox(width: (margin)),
          Expanded(
            child: ConstantWidget.getCustomText(
                s,
                textColor,
                1,
                TextAlign.left,
                FontWeight.w500,
                ConstantWidget.getScreenPercentSize(context, 1.5)),
          ),
        ],
      ),
    );
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
    return Expanded(
      flex: 9,
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
}
