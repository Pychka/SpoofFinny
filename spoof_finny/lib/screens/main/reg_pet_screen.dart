import 'package:flutter/material.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/player_factory.dart';
import 'package:spoof_finny/screens/main/main_screen.dart';

class RegPetScreen extends StatefulWidget{
  const RegPetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegPetScreenState();
}

class _RegPetScreenState extends State<RegPetScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      elevation: 3, 
      shadowColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ); 
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    );
    
    return Scaffold(
      backgroundColor: Color(0xFFE2E8F0),
      body: SafeArea(
        child: Align(
          alignment: AlignmentGeometry.center,
          child: Card(
          color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20),
            elevation: 5,
            shadowColor: Colors.black.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Center(
                    child: const Text(
                      'О питомце',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFCBD5E1),
                    thickness: 3,
                    height: 10,
                    indent: 4,
                    endIndent: 4,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                            child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: PlayerFactory.instance.getPlayers.length,
                              padding: const EdgeInsets.symmetric(horizontal: 4.0), 
                              itemBuilder: (context, index) {
                                final player = PlayerFactory.instance.getPlayers[index];
                                return ValueListenableBuilder(
                                  valueListenable: GameState.instance.userInfo.playerIdNotifier,
                                  builder:(context, value, child) {
                                    return Card(
                                      color: GameState.instance.userInfo.playerId == player.name ? Colors.blueAccent : Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              GameState.instance.userInfo.playerId = player.name;
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/player/${player.sprites[2].path}_normal.png',
                                                  height: 150,
                                                ),
                                                Text(
                                                  player.name,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: GameState.instance.userInfo.playerId == player.name ? FontWeight.w900 : FontWeight.bold,
                                                    color: GameState.instance.userInfo.playerId == player.name ? Colors.white : Colors.blueAccent
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          maxLength: 20,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Имя твоего пета',
                            prefixIcon: const Icon(Icons.pets), 
                            border: border
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Заполни имя своего пета';
                            }
                            return null;
                          },
                          onSaved: (newValue) => GameState.instance.userInfo.petName = newValue ?? '',
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      GameState.instance.startGame();
                      GameState.instance.userInfo.isInitialized = true;
                      GameState.instance.saveUserInfo();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const MainScreen()),
                      );
                    },
                    style: buttonStyle,
                    child: Text(
                      'Начать играть',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
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