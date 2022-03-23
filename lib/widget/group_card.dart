import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neksio_cenovnik/models/models.dart';
import 'package:get_storage/get_storage.dart';

class GroupCard extends StatefulWidget {
  final String code, group, subgroup, brend, description, warranty, vat, stock, price;

  const GroupCard(
      {Key? key,
      required this.group,
      required this.code,
      required this.subgroup,
      required this.brend,
      required this.description,
      required this.warranty,
      required this.vat,
      required this.stock,
      required this.price})
      : super(key: key);
  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  final favStorage = GetStorage();
  var favList = [];
  int index = 0;
  bool productExist = false;
  late CenovnikModel model;

  @override
  void initState() {
    super.initState();
    model = CenovnikModel(
        code: widget.code,
        group: widget.group,
        subgroup: widget.subgroup,
        brend: widget.brend,
        description: widget.description,
        warranty: widget.warranty,
        vat: widget.vat,
        stock: widget.stock,
        price: widget.price);

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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      if (productExist) {
                        // favs.remove(model.toJson());
                        favList.removeAt(index);
                        productExist = false;
                      } else {
                        favList.add(model.toJson());
                        productExist = true;
                      }
                      favStorage.write('fav', favList);
                    });
                  },
                  child: productExist
                      ? const Icon(CupertinoIcons.heart_fill, color: Colors.green)
                      : Icon(CupertinoIcons.heart, color: Colors.black.withOpacity(.5))),
              const SizedBox(
                height: 5,
              ),
              SelectableText(
                widget.description,
                textAlign: TextAlign.center,
                //overflow: TextOverflow.clip,
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
                "Шифра: #" + widget.code,
                style: TextStyle(
                  color: Colors.black.withOpacity(.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(.2),
                thickness: 1.0,
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                trailing: Text(
                  widget.group,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "Категорија:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                trailing: Text(
                  widget.subgroup.isNotEmpty ? widget.subgroup : "N/A",
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "Подкатегорија:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                trailing: Text(
                  widget.brend.isNotEmpty ? widget.brend : "N/A",
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "Бренд:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                trailing: Text(
                  widget.warranty + " денови",
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "Гаранција:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                trailing: Text(
                  widget.vat + "%",
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "ДДВ:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                trailing: Text(
                  widget.stock,
                  style: TextStyle(
                    color: widget.stock.length > 2 ? Colors.red : Colors.green,
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "Залиха:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                trailing: Text(
                  widget.price,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                title: const Text(
                  "Цена:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
