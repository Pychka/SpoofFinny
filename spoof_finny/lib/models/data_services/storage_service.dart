
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spoof_finny/models/game_time_manager.dart';
import 'package:spoof_finny/models/money_system/credit_card.dart';
import 'package:spoof_finny/models/money_system/debit_card.dart';
import 'package:spoof_finny/models/money_system/saving_account.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/user_info.dart';
import 'package:spoof_finny/models/vector2_adapter.dart';

class StorageService {
  StorageService._internal();

  static final StorageService instance = StorageService._internal();

  static const String _boxName = 'spoof_finny_records';
  static const String _userKey = 'user_info_data';

  late Box<UserInfo> _userBox;

  Future<void> init() async{
    await Hive.initFlutter();
    
    Hive.registerAdapter(UserInfoAdapter());
    Hive.registerAdapter(GameTimeManagerAdapter());
    Hive.registerAdapter(SavingAccountAdapter());
    Hive.registerAdapter(WalletAdapter());
    Hive.registerAdapter(CreditCardAdapter());
    Hive.registerAdapter(DebitCardAdapter());
    Hive.registerAdapter(Vector2Adapter());
    _userBox = await Hive.openBox<UserInfo>(_boxName);
  }

  UserInfo? getUserInfo() {
    return _userBox.get(_userKey);
  }

  void saveUserInfo(UserInfo userInfo) {
    _userBox.put(_userKey, userInfo);
  }

  void clearProgress() {
    _userBox.delete(_userKey);
  }
}