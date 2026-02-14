
//Assets
const pngImages = "assets/pngs";
const svgImages = "assets/svgs";

//png images
const logoDark= "$pngImages/splash_logo_dark.png";
const logoLite= "$pngImages/splash_logo_lite.png";
const userAvtar= "$pngImages/user_avatar.png";
const productImage= "$pngImages/productImage.png";
const add_cart_icon= "$pngImages/add_cart_icon.png";
const empty_cart= "$pngImages/empty_cart.png";
const arabic_cusine_icon= "$pngImages/arabic_cusine_icon.png";
const chienes_cusine= "$pngImages/chienes_cusine.png";
const indian_cusine_icon= "$pngImages/indian_cusine_icon.png";
const server_not_found = "$pngImages/server_not_found.png";
const location_marker = "$pngImages/location_marker.png";

//svg Images
const image_place_holder = "$svgImages/image_place_holder.svg";
const onboarding = "$svgImages/onboarding.svg";
const edit_pic = "$svgImages/edit_pic.svg";
const nav_earning = "$svgImages/nav_earning.svg";
const nav_noti = "$svgImages/nav_noti.svg";
const nav_order = "$svgImages/nav_order.svg";
const nav_profile = "$svgImages/nav_profile.svg";
const onboarding_bg_triangle = "$svgImages/onboarding_bg_triangle.svg";
const order_notification_icon = "$svgImages/order_noti_icon.svg";
const delivery_notification_icon = "$svgImages/delivery_noti_icon.svg";
const admin_notification_icon = "$svgImages/admin_noti_icon.svg";
const login_image = "$svgImages/login_image.svg";
const allow_location = "$svgImages/allow_location.svg";
const nav_home = "$svgImages/nav_home.svg";
const nav_offer = "$svgImages/nav_offer.svg";
const nav_support = "$svgImages/nav_customer_support.svg";
const nav_cart = "$svgImages/nav_cart.svg";
const all_categorie_icon = "$svgImages/all.svg";
const food_categorie_icon = "$svgImages/food.svg";
const grocery_categorie_icon= "$svgImages/grocery.svg";
const pharmacy_categorie_icon = "$svgImages/pharmacy.svg";
const appbar_profile_icon = "$svgImages/appbar_profile_icon.svg";
const appbar_wallet_icon = "$svgImages/appbar_wallet_icon.svg";
const location_icon = "$svgImages/location_icon.svg";
const payment_method_icon = "$svgImages/payment_method_icon.svg";
const mycoupans = "$svgImages/mycoupans.svg";
const myorders = "$svgImages/myorders.svg";
const myWallet = "$svgImages/myWallet.svg";
const logoutIcon = "$svgImages/logout_icon.svg";
const profile_icon = "$svgImages/profile_icon.svg";
const google_pay = "$svgImages/google_pay.svg";
const apple_pay = "$svgImages/apple_pay.svg";
const paypal = "$svgImages/paypal.svg";
const cart_icon = "$svgImages/cart_icon.svg";
const coupon_discout_percent = "$svgImages/coupon_discout_percent.svg";
const delete_icon = "$svgImages/delete_icon.svg";
const rating_star = "$svgImages/rating_star.svg";
const logo_dark = "$svgImages/logo_dark.svg";
const notificatons = "$svgImages/notificatons.svg";
const delivery_vehical = "$svgImages/delivery_vehical.svg";
const filterIcon = "$svgImages/filterIcon.svg";
const vegIcon = "$svgImages/vegIcon.svg";
const ratingIcons = "$svgImages/ratingIcons.svg";
const spicyIcon = "$svgImages/spicyIcon.svg";
const policyIcon = "$svgImages/policyIcon.svg";
const home_location_icon = "$svgImages/home_location_icon.svg";
const out_of_service_area = "$svgImages/out_of_service_area.svg";




///////////////////////////////Api///////////////////////////////

//const baseUrl = "http://ec2-3-107-32-229.ap-southeast-2.compute.amazonaws.com:3000";
///staging server
const baseUrl = "https://api.needdow.graphicsvolume.com";


///production server
//const baseUrl = "https://api.needow.com";
//const baseUrl = "http://ec2-3-104-164-9.ap-southeast-2.compute.amazonaws.com:3000";
const trendingProducts = "$baseUrl/products/trending";
const getUsersCartByUserId = "$baseUrl/cart/user";
const getCatetoriesbybusinesstype = "$baseUrl/categories/findCategoriesByBusinessId?id=";
const getSubcatetoriesByCategory = "$baseUrl/subcategories/by-category/";



const getProductsBySubCategory = "$baseUrl/products/sub-category/";
const getProductsByCategory = "$baseUrl/products/category/";
const getProductsByBusinessTpeCategory = "$baseUrl/products/business-type/";


const recommandedRestaurant="$baseUrl/restaurants/recommended/all";



//order APi
const createOrder = "$baseUrl/orders";

//////////Notification/////////
const notificationUrl="$baseUrl/notifications";

/////////wallet////////
const walletUrl="$baseUrl/wallet";

//////////////////////////////Auth////////////////////////////////////////////

//const sendOtpApi = "$baseUrl/auth/send-otp";
const sendOtpApi = "$baseUrl/auth/send-customer-otp";
const verifyOtpApi = "$baseUrl/auth/login";

/////////////////////////////Razorpay Credentials/////////////////////////////
String keyId = "rzp_test_Re5slMMzkUURA3";
String secretId = "XCg87i1UnAnlVVzFrrhxKanF";
////////////////////////////map keys////////////////////////////////////////
String placesKey = "AIzaSyC34xupC2K8bUvYaJ6I5waaklH8WcADpsg";
/////////////////////////////enums////////////////////////////////////////////



enum LoadProductFor  {fromBusinessType,fromCategory,fromSubCategory,forRestaurant}
enum BannerType  {forHome,forRestaurant,forGrocery,forPharmacy}