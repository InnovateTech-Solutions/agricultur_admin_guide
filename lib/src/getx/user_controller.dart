import 'package:admin_guide_agriculture/src/model/farm_model.dart';
import 'package:admin_guide_agriculture/src/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  //user
  final RxString farmerName = ''.obs;
  final RxString farmerAddress = ''.obs;
  final RxString farmerIdNumer = ''.obs;
  final RxString farmerEmail = ''.obs;
  //farm
  final RxString farmAddress = ''.obs;
  final RxString farmName = ''.obs;
  final RxString farmIdNumer = ''.obs;
  final RxString farmingType = ''.obs;
  final RxString farmsArea = ''.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    logIn();
  }

  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  void logIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    isLoggedIn.value = true;
  }

  void setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    isLoggedIn.value = value;
  }

  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    farmerName.value = prefs.getString('Name') ?? '';
    farmerEmail.value = prefs.getString('Email') ?? '';
    farmerIdNumer.value = prefs.getString('IdNumber') ?? '';
  }

  Future<void> saveUserInfo(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Name', user.name);
    await prefs.setString('Email', user.email);
    await prefs.setString('IdNumber', user.idNumber);

    await prefs.setBool('isLoggedIn', true);

    farmerName.value = user.name;
    farmerEmail.value = user.email;
    farmerAddress.value = user.address;
    farmerIdNumer.value = user.idNumber;

    isLoggedIn.value = true;
  }

  Future<void> saveFarmInfo(FarmModel farm) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('FarmName', farm.farmName);
    await prefs.setString('FarmAddress', farm.farmAddress);
    await prefs.setString('IdNumber', farm.idNumber);

    await prefs.setBool('isLoggedIn', true);

    farmName.value = farm.farmName;
    farmAddress.value = farm.farmAddress;
    farmsArea.value = farm.farmArea;
    farmerIdNumer.value = farm.idNumber;

    isLoggedIn.value = true;
  }

  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('Name');
    await prefs.remove('Email');
    await prefs.remove('IdNumber');
    await prefs.setBool('isLoggedIn', false);
    await prefs.setBool('switchState', false);

    farmerName.value = '';
    farmerEmail.value = '';
    farmerIdNumer.value = '';

    isLoggedIn.value = false;
  }
}
