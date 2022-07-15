class CenovnikModel {
  final String code, group, subgroup, brend, description, warranty, vat, stock, price;

  CenovnikModel(
      {required this.code,
      required this.group,
      required this.subgroup,
      required this.brend,
      required this.description,
      required this.warranty,
      required this.vat,
      required this.stock,
      required this.price});

  factory CenovnikModel.fromJson(json) => CenovnikModel(
        code: json['Code'] as String,
        group: json['Group'] as String,
        subgroup: json['Subgroup'] as String,
        brend: json['Brend'] as String,
        description: json['Description'] as String,
        warranty: json['warranty (days)'] as String,
        vat: json['Vat'] as String,
        stock: json['Stock'] as String,
        price: json['Price'] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Code'] = code;
    data['Group'] = group;
    data['Subgroup'] = subgroup;
    data['Brend'] = brend;
    data['Description'] = description;
    data['warranty (days)'] = warranty;
    data['Vat'] = vat;
    data['Stock'] = stock;
    data['Price'] = price;
    return data;
  }
}
