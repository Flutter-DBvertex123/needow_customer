import '../features/home/model/models/buisness_type_model.dart';
import '../features/orders/model/models/createOrderModel.dart';

PickupLocation? buildPickupLocationFromBusinessType(
    BusinessTypeModel? bt) {
  if (bt?.latitude == null || bt?.longitude == null) return null;

  return PickupLocation(
    type: "Point",
    coordinates: [
      bt!.latitude!, // latitude first
      bt.longitude!,  // longitude second
    ],
  );
}
