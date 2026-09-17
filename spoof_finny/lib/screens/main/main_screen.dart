import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_time_manager.dart';
import 'package:spoof_finny/models/user_info.dart';
import 'package:spoof_finny/screens/main/city_screen.dart';
import 'package:spoof_finny/screens/main/home_screen.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  int _currentIndex = 1;

  final List<Widget> _screens = [
    GameWidget(game: CityScreen()),
    GameWidget(game: HomeScreen()),
    GameWidget(game: CityScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context).toString();
    final info = UserInfo(
      timeManager: GameTimeManager(DateTime.now()),
      currentLocaly: Localizations.localeOf(context),
      assetsPath: 'kitty/',
      playerName: '',
      petName: 'Китик'
    );
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          SafeArea(
            child: 
              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xA0FFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: 
                      IconButton(
                          icon: const Icon(Icons.map_outlined),
                          onPressed: () => {
                            print('map')
                          },
                        ),
                    ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xA0FFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: 
                      Text(
                        DateFormat('d MMMM y', info.currentLocaly.toString()).format(info.timeManager.currentDateTime),
                        style: TextStyle(fontSize: 20),
                      )
                    ),
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xA0FFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: 
                      IconButton(
                          icon: const Icon(Icons.settings_outlined),
                          onPressed: () => {
                            print('settings')
                          },
                        ),
                    ),
                ],
              ),
              )
          ),
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
            icon: Icon(Icons.location_city_outlined),
            activeIcon: Icon(Icons.location_city_sharp),
            label: 'Город'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'Дом'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city_outlined),
            activeIcon: Icon(Icons.location_city_sharp),
            label: 'Город'
          ),
        ],
      ),
    );
  }
}