import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';

class SettingsScreen extends StatefulWidget{
  const SettingsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    );
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: SizedBox(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Настройки', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
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
                          hintText: 'Имя твоего пета',
                          prefixIcon: const Icon(Icons.pets), 
                          border: border
                        ),
                        initialValue: GameState.instance.userInfo.petName,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      GameState.instance.saveUserInfo();
                    },
                    style: buttonStyle,
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      )
    );
  }
}