import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/main/reg_pet_screen.dart';

class RegChildScreen extends StatefulWidget{
  const RegChildScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegChildScreenState();
}

class _RegChildScreenState extends State<RegChildScreen> with WidgetsBindingObserver {
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
                      'Расскажи о себе',
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
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          maxLength: 20,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Твоё имя',
                            border: border
                          ),
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Заполни своё имя';
                            }
                            return null;
                          },
                          onSaved: (newValue) => GameState.instance.userInfo.playerName = newValue ?? '',
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Твой возраст',
                            counterText: '',
                            prefixIcon: const Icon(Icons.cake_outlined),
                            border: border,
                          ),
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          validator: (value) {
                            if(value == null || int.tryParse(value) == null){
                              return 'Заполни свой возраст';
                            }
                            return null;
                          },
                          onSaved: (newValue) => GameState.instance.userInfo.age = int.tryParse(newValue ?? '') ?? 0,
                        ),
                      ],
                    )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const RegPetScreen()),
                      );

                    },
                    style: buttonStyle,
                    child: Text(
                      'Продолжить',
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