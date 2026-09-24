import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/additional/stats_screen.dart';
import 'package:spoof_finny/screens/additional/tasks_screen.dart';
import 'package:spoof_finny/screens/main/city_screen.dart';
import 'package:spoof_finny/screens/main/home_screen.dart';
import 'package:spoof_finny/screens/main/kitchen_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 1;
  late final List<Widget> _screens;

  void changeScreen(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

  @override
  void initState() {
    _screens = [
      GameWidget(game: CityScreen()),
      GameWidget(game: HomeScreen(changeScreen: changeScreen)),
      GameWidget(game: KitchenScreen(changeScreen: changeScreen)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    GameState.instance.userInfo.localeCode = Localizations.localeOf(context).toString();
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
           Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:
              SafeArea(
              child: 
                Padding(
                  padding: EdgeInsetsGeometry.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        margin: EdgeInsets.all(5),
                        color: Color(0xA0FFFFFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: 
                          SizedBox(
                            width: 50,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.map_outlined),
                                  onPressed: () {

                                  },
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  height: 5,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.task_alt_outlined),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return const TasksScreen();
                                      }
                                    );
                                  }
                                ),
                              ],
                            ),
                          )
                        ),
                        Expanded(
                              child: Card(
                              color: Color(0xA0FFFFFF),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: 
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return const StatsScreen();
                                      }
                                    );
                                  },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                child: Row(
                                  spacing: 5,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: screenWidth * 0.25,
                                      ),
                                      child: ValueListenableBuilder<double>(
                                        valueListenable: GameState.instance.userInfo.moneyManager.wallet.moneyNotifier,
                                        builder: (context, value, child) => Text(
                                            "${value % 1 == 0 ? value.toInt() : value.toStringAsFixed(2)}🪙",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ),
                                    Expanded(
                                      child: 
                                        ValueListenableBuilder<int>(
                                          valueListenable: GameState.instance.userInfo.experienceSystem.currentExperienceNotifier,
                                          builder: (context, currentExperience, child) {
                                            return Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                LinearProgressIndicator(
                                                  value: GameState.instance.userInfo.experienceSystem.getPercentOfNextLevel,
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.green,
                                                  minHeight: 30,
                                                  backgroundColor: Colors.grey,
                                                ),
                                                Text(
                                                  '$currentExperience/${GameState.instance.userInfo.experienceSystem.nextLevelExperience}',
                                                  style: const TextStyle(
                                                    color: Colors.white, 
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ]);
                                            }
                                        )
                                    ),
                                    ValueListenableBuilder<int>(
                                      valueListenable: GameState.instance.userInfo.experienceSystem.currentLevelNotifier,
                                      builder: (context, value, child) =>
                                        Text(
                                          '${GameState.instance.userInfo.experienceSystem.currentLevel}⭐',
                                          style: const TextStyle(
                                            color: Colors.black, 
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        )
                                    ),
                                    
                                  ],
                                ),
                              ),
                            )
                          ),
                            ),
                      Card(
                        margin: EdgeInsets.all(5),
                        color: Color(0xA0FFFFFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: 
                          IconButton(
                              icon: const Icon(Icons.settings_outlined),
                              onPressed: () => {
                                
                              },
                            ),
                        ),
                  ],
                ),
                )
            ),
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
            activeIcon: Icon(Icons.home_sharp),
            label: 'Дом'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            activeIcon: Icon(Icons.food_bank_sharp),
            label: 'Кухня'
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