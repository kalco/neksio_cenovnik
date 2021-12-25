import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:neksio_cenovnik/widget/group_card.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteBottomSheet extends StatefulWidget {
  const FavoriteBottomSheet({Key? key, r}) : super(key: key);
  @override
  State<FavoriteBottomSheet> createState() => _FavoriteBottomSheetState();
}

class _FavoriteBottomSheetState extends State<FavoriteBottomSheet> {
  var favList = [];
  @override
  Widget build(BuildContext context) {
    final favStorage = GetStorage();
    favList = favStorage.read('fav');

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.black)),
                      const Text(
                        "Омилени производи",
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: favList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    final model = CenovnikModel.fromJson(favList[i]);
                    return InkWell(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (BuildContext context) => GroupCard(
                            brend: model.brend,
                            code: model.code,
                            description: model.description,
                            group: model.group,
                            price: model.price,
                            stock: model.stock,
                            subgroup: model.subgroup,
                            vat: model.vat,
                            warranty: model.warranty,
                          ),
                        );
                      },
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.description,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  model.price,
                                                  style: TextStyle(
                                                    color: Colors.black.withOpacity(.5),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          favList.remove(favList[i]);
                                          favStorage.write('fav', favList);
                                        });
                                      },
                                      child: Icon(Icons.delete, color: Colors.black.withOpacity(.5)))
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
                    );
                  },
                )
              ],
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
