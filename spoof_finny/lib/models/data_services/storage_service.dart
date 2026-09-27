import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spoof_finny/models/experience_system.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';
import 'package:spoof_finny/models/time_system/game_time_manager.dart';
import 'package:spoof_finny/models/items/food.dart';
import 'package:spoof_finny/models/items/inventory.dart';
import 'package:spoof_finny/models/items/item.dart';
import 'package:spoof_finny/models/money_system/credit_card.dart';
import 'package:spoof_finny/models/money_system/debit_card.dart';
import 'package:spoof_finny/models/money_system/money_manager.dart';
import 'package:spoof_finny/models/money_system/saving_account.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/shop_system/shop.dart';
import 'package:spoof_finny/models/shop_system/shop_manager.dart';
import 'package:spoof_finny/models/shop_system/shop_product.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/player_stat.dart';
import 'package:spoof_finny/models/stats/stat_manager.dart';
import 'package:spoof_finny/models/stats/stat_type.dart';
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
    Hive.registerAdapter(ExperienceSystemAdapter());
    Hive.registerAdapter(MoneyManagerAdapter());
    Hive.registerAdapter(StatManagerAdapter());
    Hive.registerAdapter(PlayerStatAdapter());
    Hive.registerAdapter(StatTypeAdapter());
    Hive.registerAdapter(InventoryAdapter());
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(ChangeStatValueGameEventAdapter());
    Hive.registerAdapter(OperatorAdapter());
    Hive.registerAdapter(FoodAdapter());
    Hive.registerAdapter(ShopManagerAdapter());
    Hive.registerAdapter(ShopProductAdapter());
    Hive.registerAdapter(ShopAdapter());
    Hive.registerAdapter(GameTimeAdapter());
    Hive.registerAdapter(GameTimeChangedEventAdapter());
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