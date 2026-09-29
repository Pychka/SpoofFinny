import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spoof_finny/models/data_services/storage_service.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/main/reg_child_screen.dart';

class RegParentScreen extends StatefulWidget{
  const RegParentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegParentScreenState();
}

class _RegParentScreenState extends State<RegParentScreen> with WidgetsBindingObserver {
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
                      'SpoofFinny',
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
                            hintText: 'Ваше имя',
                            border: border
                          ),
                          autovalidateMode: AutovalidateMode.onUnfocus, 
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Имя не может быть пустым или начинаться с пробела';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          maxLength: 4,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            hintText: 'Введите ПИН-код',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          autovalidateMode: AutovalidateMode.onUnfocus, 
                          validator: (value) {
                            if(value == null || value.length != 4){
                              return 'Заполните все 4 пина';
                            }
                            return null;
                          },
                        ),
                      ],
                    )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const RegChildScreen()),
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