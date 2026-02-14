class ProductQtyData {
  int quantity;
  bool requiresPrescription;
  String prescriptionUrl;

  ProductQtyData({
    required this.quantity,
    this.requiresPrescription = false,
    this.prescriptionUrl = "",
  });

  ProductQtyData copyWith({
    int? quantity,
    bool? requiresPrescription,
    String? prescriptionUrl,
  }) {
    return ProductQtyData(
      quantity: quantity ?? this.quantity,
      requiresPrescription:
      requiresPrescription ?? this.requiresPrescription,
      prescriptionUrl: prescriptionUrl ?? this.prescriptionUrl,
    );
  }
}