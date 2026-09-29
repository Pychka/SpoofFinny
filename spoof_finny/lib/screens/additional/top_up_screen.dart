import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/money_system/money_storage.dart';
import 'package:spoof_finny/screens/additional/remove_leading_zero_formatter.dart';

class TopUpScreen extends StatefulWidget{
  final MoneyStorage bill;
  const TopUpScreen({
    super.key,
    required this.bill
  });
  @override
  State<StatefulWidget> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen>{
  MoneyStorage? selectedBill;
  final _formKey = GlobalKey<FormState>();
  double? money;
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: SizedBox(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Пополнение', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),ValueListenableBuilder<double>(
                  valueListenable: widget.bill.moneyNotifier,
                  builder: (context, value, child) => 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Куда: ${widget.bill.billType}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Баланс: ${widget.bill.money.toStringAsFixed(2)}🪙',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ),
                const Divider(),
                DropdownMenu(
                  label: const Text('С какого счёта пополнить?'),
                  enableSearch: true,
                  dropdownMenuEntries: GameState.instance.userInfo.moneyManager.allBillsWithoutOne(widget.bill).map<DropdownMenuEntry<MoneyStorage>>((MoneyStorage bill) {
                    return DropdownMenuEntry<MoneyStorage>(
                      value: bill,
                      label: bill.billType,
                    );
                  }).toList(),
                  onSelected: (MoneyStorage? bill) {
                    setState(() {
                      selectedBill = bill;
                    });
                  },
                ),
                ValueListenableBuilder<double>(
                  valueListenable: selectedBill?.moneyNotifier ?? ValueNotifier(0),
                  builder: (context, value, child) => 
                    Text(
                      selectedBill == null ? 'Выберите счёт' : 'Баланс: ${selectedBill?.money.toStringAsFixed(2)}🪙',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d*')), RemoveLeadingZeroFormatter(),],
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Сумма',
                      counterText: '',
                      prefixIcon: const Icon(Icons.attach_money_outlined),
                      border: border,
                    ),
                    enabled: selectedBill != null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: '0',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не должно быть пустым';
                      }
                      final normalizedValue = value.replaceAll(',', '.');
                      if (double.tryParse(normalizedValue) == null) {
                        return 'Введите корректное число';
                      }
                      if(selectedBill!.money < double.tryParse(normalizedValue)!){
                        return 'Сумма превышает допустимую';
                      }
                      return null;
                    },
                    
                    onSaved: (newValue) => money = double.tryParse(newValue ?? '') ?? 0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    if(!selectedBill!.get(money!)) return;
                    widget.bill.money += money!;
                    Navigator.of(context).pop();
                  },
                  style: buttonStyle,
                  child: Text(
                    'Пополнить',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}
