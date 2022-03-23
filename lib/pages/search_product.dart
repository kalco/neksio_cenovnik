import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neksio_cenovnik/widget/group_card.dart';
import '../models/models.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final _searchview = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  String query = '';
  late List<CenovnikModel> filteredList = [];

  @override
  // ignore: must_call_super
  void initState() {
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
    return Scaffold(
      body: Column(
        children: [
           Padding(
             
                padding: const EdgeInsets.fromLTRB(20,35,20,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.black)),
                    const Text(
                      "Прабарување",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
          _createSearchView(),
          StreamBuilder(
            stream: databaseReference.onValue,
            builder: (context, snapshot) {
              List<CenovnikModel> cenovnikList = [];
              if (snapshot.hasData) {
                final card = List<dynamic>.from(
                    (snapshot.data! as Event).snapshot.value);
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
              return query.isNotEmpty
                  ? _performSearch(cenovnikList)
                  : Container();
            },
          ),
          //  _firstSearch ? normalView() :_performSearch(storyController.storyData)
        ],
      ),
    );
  }

  //Create a SearchView
  Widget _createSearchView() {
    return Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  height: 100,
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: CupertinoTextField(
                          autofocus: true,
                          controller: _searchview,
                          placeholder: "Внесете име на производот овде...",
                          placeholderStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          style: const TextStyle(color: Colors.black),
                          suffix: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Icon(
                              CupertinoIcons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                              border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )),
                        ),
                      ),
                    ),
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
    return Flexible(
      //alignment: Alignment.topLeft,
      //padding: EdgeInsets.all(6),
      child: ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) => InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredList[index].description,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${filteredList[index].price} / ${filteredList[index].group}',
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(.2),
                        thickness: 1.5,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (BuildContext context) => GroupCard(
                      brend: filteredList[index].brend,
                      code: filteredList[index].code,
                      description: filteredList[index].description,
                      group: filteredList[index].group,
                      price: filteredList[index].price,
                      stock: filteredList[index].stock,
                      subgroup: filteredList[index].subgroup,
                      vat: filteredList[index].vat,
                      warranty: filteredList[index].warranty,
                    ),
                  );
                },
              )),
    );
  }
}
