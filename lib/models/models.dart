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
        code: json['productCode'] as String,
        group: json['category'] as String,
        subgroup: json['manufacturer'] as String,
        brend: json['manufacturer'] as String,
        description: json['description'] as String,
        warranty: json['guaranteePeriodInDays'] as String,
        vat: json['tax'] as String,
        stock: json['inStock'] as String,
        price: json['retailPriceWTax'] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productCode'] = code;
    data['category'] = group;
    data['manufacturer'] = subgroup;
    data['manufacturer'] = brend;
    data['description'] = description;
    data['guaranteePeriodInDays'] = warranty;
    data['tax'] = vat;
    data['inStock'] = stock;
    data['retailPriceWTax'] = price;
    return data;
  }
}
