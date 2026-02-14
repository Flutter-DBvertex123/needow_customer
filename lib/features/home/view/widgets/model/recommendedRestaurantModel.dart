// /// statusCode : 200
// /// message : "Recommended restaurants fetched successfully"
// /// data : [{"location":{"type":"Point","coordinates":[76.238948,11.2949113]},"_id":"6989a9293590d5c4243467eb","name":"cafecoffeeday","ownerName":"ABCD","mobile":"1231231230","email":"dbtester91233@gmail.com","address":"Nilambur - Adyanpara Rd, Nilambur, Kerala 679329, India","cityArea":"[object Object]","cuisineTypes":["Indian"],"restaurantType":"veg","accountHolderName":"owner cafe","bankName":"acascsacasc","accountNumber":"125478963","ifscCode":"ASDFDASD147852693","deliveryRadius":"5","branchName":"indore","licenseNo":"ASASASAS7257272275","licenseValidity":"2026-02-27T00:00:00.000Z","logo":"https://needdow-doc.s3.ap-southeast-2.amazonaws.com/documents/1770629416960-Amul-Pasteurised-Butter-100-g.webp","coverPhoto":"https://needdow-doc.s3.ap-southeast-2.amazonaws.com/documents/1770629417033-classic-cheese-burger-with-beef-cutlet-vegetables-onions-isolated-white-background_123827-29709.avif","workingHours":{"start":"11:03","end":"23:03","_id":"6989a9293590d5c4243467ec"},"avgPreparationTime":30,"deliveryChargeMin":5,"deliveryChargeAfter1km":5,"isDeliveryAvailable":true,"isTakeawayAvailable":false,"isPureVeg":false,"isFeatured":false,"totalOrders":0,"status":"active","isActive":true,"rating":0,"role":"restaurant_owner","createdAt":"2026-02-09T09:30:17.586Z","updatedAt":"2026-02-09T10:26:33.535Z","__v":0,"isRecommended":true}]
//
// class RecommendedRestaurantModel {
//   RecommendedRestaurantModel({
//       num? statusCode,
//       String? message,
//       List<Data>? data,}){
//     _statusCode = statusCode;
//     _message = message;
//     _data = data;
// }
//
//   RecommendedRestaurantModel.fromJson(dynamic json) {
//     _statusCode = json['statusCode'];
//     _message = json['message'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data.fromJson(v));
//       });
//     }
//   }
//   num? _statusCode;
//   String? _message;
//   List<Data>? _data;
// RecommendedRestaurantModel copyWith({  num? statusCode,
//   String? message,
//   List<Data>? data,
// }) => RecommendedRestaurantModel(  statusCode: statusCode ?? _statusCode,
//   message: message ?? _message,
//   data: data ?? _data,
// );
//   num? get statusCode => _statusCode;
//   String? get message => _message;
//   List<Data>? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['statusCode'] = _statusCode;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// location : {"type":"Point","coordinates":[76.238948,11.2949113]}
// /// _id : "6989a9293590d5c4243467eb"
// /// name : "cafecoffeeday"
// /// ownerName : "ABCD"
// /// mobile : "1231231230"
// /// email : "dbtester91233@gmail.com"
// /// address : "Nilambur - Adyanpara Rd, Nilambur, Kerala 679329, India"
// /// cityArea : "[object Object]"
// /// cuisineTypes : ["Indian"]
// /// restaurantType : "veg"
// /// accountHolderName : "owner cafe"
// /// bankName : "acascsacasc"
// /// accountNumber : "125478963"
// /// ifscCode : "ASDFDASD147852693"
// /// deliveryRadius : "5"
// /// branchName : "indore"
// /// licenseNo : "ASASASAS7257272275"
// /// licenseValidity : "2026-02-27T00:00:00.000Z"
// /// logo : "https://needdow-doc.s3.ap-southeast-2.amazonaws.com/documents/1770629416960-Amul-Pasteurised-Butter-100-g.webp"
// /// coverPhoto : "https://needdow-doc.s3.ap-southeast-2.amazonaws.com/documents/1770629417033-classic-cheese-burger-with-beef-cutlet-vegetables-onions-isolated-white-background_123827-29709.avif"
// /// workingHours : {"start":"11:03","end":"23:03","_id":"6989a9293590d5c4243467ec"}
// /// avgPreparationTime : 30
// /// deliveryChargeMin : 5
// /// deliveryChargeAfter1km : 5
// /// isDeliveryAvailable : true
// /// isTakeawayAvailable : false
// /// isPureVeg : false
// /// isFeatured : false
// /// totalOrders : 0
// /// status : "active"
// /// isActive : true
// /// rating : 0
// /// role : "restaurant_owner"
// /// createdAt : "2026-02-09T09:30:17.586Z"
// /// updatedAt : "2026-02-09T10:26:33.535Z"
// /// __v : 0
// /// isRecommended : true
//
// class Data {
//   Data({
//       Location? location,
//       String? id,
//       String? name,
//       String? ownerName,
//       String? mobile,
//       String? email,
//       String? address,
//       String? cityArea,
//       List<String>? cuisineTypes,
//       String? restaurantType,
//       String? accountHolderName,
//       String? bankName,
//       String? accountNumber,
//       String? ifscCode,
//       String? deliveryRadius,
//       String? branchName,
//       String? licenseNo,
//       String? licenseValidity,
//       String? logo,
//       String? coverPhoto,
//       WorkingHours? workingHours,
//       num? avgPreparationTime,
//       num? deliveryChargeMin,
//       num? deliveryChargeAfter1km,
//       bool? isDeliveryAvailable,
//       bool? isTakeawayAvailable,
//       bool? isPureVeg,
//       bool? isFeatured,
//       num? totalOrders,
//       String? status,
//       bool? isActive,
//       num? rating,
//       String? role,
//       String? createdAt,
//       String? updatedAt,
//       num? v,
//       bool? isRecommended,}){
//     _location = location;
//     _id = id;
//     _name = name;
//     _ownerName = ownerName;
//     _mobile = mobile;
//     _email = email;
//     _address = address;
//     _cityArea = cityArea;
//     _cuisineTypes = cuisineTypes;
//     _restaurantType = restaurantType;
//     _accountHolderName = accountHolderName;
//     _bankName = bankName;
//     _accountNumber = accountNumber;
//     _ifscCode = ifscCode;
//     _deliveryRadius = deliveryRadius;
//     _branchName = branchName;
//     _licenseNo = licenseNo;
//     _licenseValidity = licenseValidity;
//     _logo = logo;
//     _coverPhoto = coverPhoto;
//     _workingHours = workingHours;
//     _avgPreparationTime = avgPreparationTime;
//     _deliveryChargeMin = deliveryChargeMin;
//     _deliveryChargeAfter1km = deliveryChargeAfter1km;
//     _isDeliveryAvailable = isDeliveryAvailable;
//     _isTakeawayAvailable = isTakeawayAvailable;
//     _isPureVeg = isPureVeg;
//     _isFeatured = isFeatured;
//     _totalOrders = totalOrders;
//     _status = status;
//     _isActive = isActive;
//     _rating = rating;
//     _role = role;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _v = v;
//     _isRecommended = isRecommended;
// }
//
//   Data.fromJson(dynamic json) {
//     _location = json['location'] != null ? Location.fromJson(json['location']) : null;
//     _id = json['_id'];
//     _name = json['name'];
//     _ownerName = json['ownerName'];
//     _mobile = json['mobile'];
//     _email = json['email'];
//     _address = json['address'];
//     _cityArea = json['cityArea'];
//     _cuisineTypes = json['cuisineTypes'] != null ? json['cuisineTypes'].cast<String>() : [];
//     _restaurantType = json['restaurantType'];
//     _accountHolderName = json['accountHolderName'];
//     _bankName = json['bankName'];
//     _accountNumber = json['accountNumber'];
//     _ifscCode = json['ifscCode'];
//     _deliveryRadius = json['deliveryRadius'];
//     _branchName = json['branchName'];
//     _licenseNo = json['licenseNo'];
//     _licenseValidity = json['licenseValidity'];
//     _logo = json['logo'];
//     _coverPhoto = json['coverPhoto'];
//     _workingHours = json['workingHours'] != null ? WorkingHours.fromJson(json['workingHours']) : null;
//     _avgPreparationTime = json['avgPreparationTime'];
//     _deliveryChargeMin = json['deliveryChargeMin'];
//     _deliveryChargeAfter1km = json['deliveryChargeAfter1km'];
//     _isDeliveryAvailable = json['isDeliveryAvailable'];
//     _isTakeawayAvailable = json['isTakeawayAvailable'];
//     _isPureVeg = json['isPureVeg'];
//     _isFeatured = json['isFeatured'];
//     _totalOrders = json['totalOrders'];
//     _status = json['status'];
//     _isActive = json['isActive'];
//     _rating = json['rating'];
//     _role = json['role'];
//     _createdAt = json['createdAt'];
//     _updatedAt = json['updatedAt'];
//     _v = json['__v'];
//     _isRecommended = json['isRecommended'];
//   }
//   Location? _location;
//   String? _id;
//   String? _name;
//   String? _ownerName;
//   String? _mobile;
//   String? _email;
//   String? _address;
//   String? _cityArea;
//   List<String>? _cuisineTypes;
//   String? _restaurantType;
//   String? _accountHolderName;
//   String? _bankName;
//   String? _accountNumber;
//   String? _ifscCode;
//   String? _deliveryRadius;
//   String? _branchName;
//   String? _licenseNo;
//   String? _licenseValidity;
//   String? _logo;
//   String? _coverPhoto;
//   WorkingHours? _workingHours;
//   num? _avgPreparationTime;
//   num? _deliveryChargeMin;
//   num? _deliveryChargeAfter1km;
//   bool? _isDeliveryAvailable;
//   bool? _isTakeawayAvailable;
//   bool? _isPureVeg;
//   bool? _isFeatured;
//   num? _totalOrders;
//   String? _status;
//   bool? _isActive;
//   num? _rating;
//   String? _role;
//   String? _createdAt;
//   String? _updatedAt;
//   num? _v;
//   bool? _isRecommended;
// Data copyWith({  Location? location,
//   String? id,
//   String? name,
//   String? ownerName,
//   String? mobile,
//   String? email,
//   String? address,
//   String? cityArea,
//   List<String>? cuisineTypes,
//   String? restaurantType,
//   String? accountHolderName,
//   String? bankName,
//   String? accountNumber,
//   String? ifscCode,
//   String? deliveryRadius,
//   String? branchName,
//   String? licenseNo,
//   String? licenseValidity,
//   String? logo,
//   String? coverPhoto,
//   WorkingHours? workingHours,
//   num? avgPreparationTime,
//   num? deliveryChargeMin,
//   num? deliveryChargeAfter1km,
//   bool? isDeliveryAvailable,
//   bool? isTakeawayAvailable,
//   bool? isPureVeg,
//   bool? isFeatured,
//   num? totalOrders,
//   String? status,
//   bool? isActive,
//   num? rating,
//   String? role,
//   String? createdAt,
//   String? updatedAt,
//   num? v,
//   bool? isRecommended,
// }) => Data(  location: location ?? _location,
//   id: id ?? _id,
//   name: name ?? _name,
//   ownerName: ownerName ?? _ownerName,
//   mobile: mobile ?? _mobile,
//   email: email ?? _email,
//   address: address ?? _address,
//   cityArea: cityArea ?? _cityArea,
//   cuisineTypes: cuisineTypes ?? _cuisineTypes,
//   restaurantType: restaurantType ?? _restaurantType,
//   accountHolderName: accountHolderName ?? _accountHolderName,
//   bankName: bankName ?? _bankName,
//   accountNumber: accountNumber ?? _accountNumber,
//   ifscCode: ifscCode ?? _ifscCode,
//   deliveryRadius: deliveryRadius ?? _deliveryRadius,
//   branchName: branchName ?? _branchName,
//   licenseNo: licenseNo ?? _licenseNo,
//   licenseValidity: licenseValidity ?? _licenseValidity,
//   logo: logo ?? _logo,
//   coverPhoto: coverPhoto ?? _coverPhoto,
//   workingHours: workingHours ?? _workingHours,
//   avgPreparationTime: avgPreparationTime ?? _avgPreparationTime,
//   deliveryChargeMin: deliveryChargeMin ?? _deliveryChargeMin,
//   deliveryChargeAfter1km: deliveryChargeAfter1km ?? _deliveryChargeAfter1km,
//   isDeliveryAvailable: isDeliveryAvailable ?? _isDeliveryAvailable,
//   isTakeawayAvailable: isTakeawayAvailable ?? _isTakeawayAvailable,
//   isPureVeg: isPureVeg ?? _isPureVeg,
//   isFeatured: isFeatured ?? _isFeatured,
//   totalOrders: totalOrders ?? _totalOrders,
//   status: status ?? _status,
//   isActive: isActive ?? _isActive,
//   rating: rating ?? _rating,
//   role: role ?? _role,
//   createdAt: createdAt ?? _createdAt,
//   updatedAt: updatedAt ?? _updatedAt,
//   v: v ?? _v,
//   isRecommended: isRecommended ?? _isRecommended,
// );
//   Location? get location => _location;
//   String? get id => _id;
//   String? get name => _name;
//   String? get ownerName => _ownerName;
//   String? get mobile => _mobile;
//   String? get email => _email;
//   String? get address => _address;
//   String? get cityArea => _cityArea;
//   List<String>? get cuisineTypes => _cuisineTypes;
//   String? get restaurantType => _restaurantType;
//   String? get accountHolderName => _accountHolderName;
//   String? get bankName => _bankName;
//   String? get accountNumber => _accountNumber;
//   String? get ifscCode => _ifscCode;
//   String? get deliveryRadius => _deliveryRadius;
//   String? get branchName => _branchName;
//   String? get licenseNo => _licenseNo;
//   String? get licenseValidity => _licenseValidity;
//   String? get logo => _logo;
//   String? get coverPhoto => _coverPhoto;
//   WorkingHours? get workingHours => _workingHours;
//   num? get avgPreparationTime => _avgPreparationTime;
//   num? get deliveryChargeMin => _deliveryChargeMin;
//   num? get deliveryChargeAfter1km => _deliveryChargeAfter1km;
//   bool? get isDeliveryAvailable => _isDeliveryAvailable;
//   bool? get isTakeawayAvailable => _isTakeawayAvailable;
//   bool? get isPureVeg => _isPureVeg;
//   bool? get isFeatured => _isFeatured;
//   num? get totalOrders => _totalOrders;
//   String? get status => _status;
//   bool? get isActive => _isActive;
//   num? get rating => _rating;
//   String? get role => _role;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   num? get v => _v;
//   bool? get isRecommended => _isRecommended;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_location != null) {
//       map['location'] = _location?.toJson();
//     }
//     map['_id'] = _id;
//     map['name'] = _name;
//     map['ownerName'] = _ownerName;
//     map['mobile'] = _mobile;
//     map['email'] = _email;
//     map['address'] = _address;
//     map['cityArea'] = _cityArea;
//     map['cuisineTypes'] = _cuisineTypes;
//     map['restaurantType'] = _restaurantType;
//     map['accountHolderName'] = _accountHolderName;
//     map['bankName'] = _bankName;
//     map['accountNumber'] = _accountNumber;
//     map['ifscCode'] = _ifscCode;
//     map['deliveryRadius'] = _deliveryRadius;
//     map['branchName'] = _branchName;
//     map['licenseNo'] = _licenseNo;
//     map['licenseValidity'] = _licenseValidity;
//     map['logo'] = _logo;
//     map['coverPhoto'] = _coverPhoto;
//     if (_workingHours != null) {
//       map['workingHours'] = _workingHours?.toJson();
//     }
//     map['avgPreparationTime'] = _avgPreparationTime;
//     map['deliveryChargeMin'] = _deliveryChargeMin;
//     map['deliveryChargeAfter1km'] = _deliveryChargeAfter1km;
//     map['isDeliveryAvailable'] = _isDeliveryAvailable;
//     map['isTakeawayAvailable'] = _isTakeawayAvailable;
//     map['isPureVeg'] = _isPureVeg;
//     map['isFeatured'] = _isFeatured;
//     map['totalOrders'] = _totalOrders;
//     map['status'] = _status;
//     map['isActive'] = _isActive;
//     map['rating'] = _rating;
//     map['role'] = _role;
//     map['createdAt'] = _createdAt;
//     map['updatedAt'] = _updatedAt;
//     map['__v'] = _v;
//     map['isRecommended'] = _isRecommended;
//     return map;
//   }
//
// }
//
// /// start : "11:03"
// /// end : "23:03"
// /// _id : "6989a9293590d5c4243467ec"
//
// class WorkingHours {
//   WorkingHours({
//       String? start,
//       String? end,
//       String? id,}){
//     _start = start;
//     _end = end;
//     _id = id;
// }
//
//   WorkingHours.fromJson(dynamic json) {
//     _start = json['start'];
//     _end = json['end'];
//     _id = json['_id'];
//   }
//   String? _start;
//   String? _end;
//   String? _id;
// WorkingHours copyWith({  String? start,
//   String? end,
//   String? id,
// }) => WorkingHours(  start: start ?? _start,
//   end: end ?? _end,
//   id: id ?? _id,
// );
//   String? get start => _start;
//   String? get end => _end;
//   String? get id => _id;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['start'] = _start;
//     map['end'] = _end;
//     map['_id'] = _id;
//     return map;
//   }
//
// }
//
// /// type : "Point"
// /// coordinates : [76.238948,11.2949113]
//
// class Location {
//   Location({
//       String? type,
//       List<num>? coordinates,}){
//     _type = type;
//     _coordinates = coordinates;
// }
//
//   Location.fromJson(dynamic json) {
//     _type = json['type'];
//     _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
//   }
//   String? _type;
//   List<num>? _coordinates;
// Location copyWith({  String? type,
//   List<num>? coordinates,
// }) => Location(  type: type ?? _type,
//   coordinates: coordinates ?? _coordinates,
// );
//   String? get type => _type;
//   List<num>? get coordinates => _coordinates;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['type'] = _type;
//     map['coordinates'] = _coordinates;
//     return map;
//   }
//
// }