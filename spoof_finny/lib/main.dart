import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:json_serializer/json_serializer.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
import 'package:spoof_finny/models/money_system/wallet.dart';
import 'package:spoof_finny/models/player.dart';
import 'package:spoof_finny/models/user_info.dart';
import 'package:spoof_finny/screens/main/start_screen.dart';
import 'screens/main/main_screen.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    JsonSerializer.options = JsonSerializerOptions(types: [
      UserType<UserInfo>(UserInfo.new),
      UserType<MoneyStorage>(MoneyStorage.new),
      UserType<Player>(Player.new),
      EnumType<PlayerState>(PlayerState.values),
      UserType<Wallet>(Wallet.new),
    ]);
    GameState.instance.init();
    return MaterialApp(
      title: 'SpoofFinny',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: Brightness.light, 
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFFFFFFF),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Color(0xFF94A3B8)
        ),
      ),
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      home: GameState.instance.userInfo.isInitialized ? const MainScreen() : const StartScreen(),
    );
  }
}
