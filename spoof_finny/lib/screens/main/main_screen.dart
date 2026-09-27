import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/main/rooms/bathroom_screen.dart';
import 'package:spoof_finny/screens/main/rooms/bedroom_screen.dart';
import 'package:spoof_finny/screens/main/rooms/home_screen.dart';
import 'package:spoof_finny/screens/main/rooms/kitchen_screen.dart';
import 'package:spoof_finny/screens/main/rooms/livingroom_screen.dart';
import 'package:spoof_finny/screens/main/map_screen.dart';
import 'package:spoof_finny/screens/main/top_main_menu.dart';
import 'package:spoof_finny/screens/additional/shop_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 2;
  late final List<Widget> _screens;
  final _livingRoomNavigatorKey = GlobalKey<NavigatorState>();
  final _homeNavigatorKey = GlobalKey<NavigatorState>();
  final _kitchenNavigatorKey = GlobalKey<NavigatorState>();
  final _bathroomNavigatorKey = GlobalKey<NavigatorState>();
  final _bedroomNavigatorKey = GlobalKey<NavigatorState>();

  void changeMainScreen(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

  void changeScreen(int index) {
    _livingRoomNavigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (_) => _screens[index],
      ),
    );
  }

  void openScreen(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _screens[index],
      ),
    );
  }

  @override
  void initState() {
    _screens = [
      const ShopScreen(),
      GameWidget(game: MapScreen(changeMainScreen: changeMainScreen, changeScreen: openScreen)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GameState.instance.userInfo.localeCode = Localizations.localeOf(context).toString();
    return Scaffold(
      extendBody: false,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
            _buildNavigator(
              navigatorKey: _livingRoomNavigatorKey,
              child: GameWidget(
                game: LivingroomScreen(
                  changeScreen: changeMainScreen,
                ),
              ),
            ),

              _buildNavigator(
              navigatorKey: _kitchenNavigatorKey,
              child: GameWidget(
                game: KitchenScreen(
                  changeScreen: changeMainScreen,
                ),
              ),
            ),

            _buildNavigator(
              navigatorKey: _homeNavigatorKey,
              child: GameWidget(
                game: HomeScreen(
                  changeScreen: changeMainScreen,
                ),
              ),
            ),

            _buildNavigator(
              navigatorKey: _bathroomNavigatorKey,
              child: GameWidget(
                game: BathroomScreen(
                  changeScreen: changeMainScreen,
                ),
              ),
            ),

            _buildNavigator(
              navigatorKey: _bedroomNavigatorKey,
              child: GameWidget(
                game: BedroomScreen(
                  changeScreen: changeMainScreen,
                ),
              ),
            ),
            ]
          ),
          TopMainMenu(changeScreen: openScreen,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.living_outlined),
            activeIcon: Icon(Icons.living_sharp),
            label: 'Гостинная'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            activeIcon: Icon(Icons.food_bank_sharp),
            label: 'Кухня'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_sharp),
            label: 'Прихожая'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bathroom_outlined),
            activeIcon: Icon(Icons.bathroom_sharp),
            label: 'Ванная'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed_outlined),
            activeIcon: Icon(Icons.bed_sharp),
            label: 'Спальня'
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      StorageService.instance.saveUserInfo(GameState.instance.userInfo);
    }
  }
}

Widget _buildNavigator({
  required GlobalKey<NavigatorState> navigatorKey,
  required Widget child,
}) {
  return Navigator(
    key: navigatorKey,
    onGenerateRoute: (_) {
      return MaterialPageRoute(
        builder: (_) => child,
      );
    },
  );
}