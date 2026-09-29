import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/elements/bill_card.dart';

class BillsScreen extends StatefulWidget{
  const BillsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen>{
  @override
  Widget build(BuildContext context) {
    final bills = [GameState.instance.userInfo.moneyManager.wallet, ...GameState.instance.userInfo.moneyManager.moneyBills];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: SizedBox(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Счета', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(), 
                  itemCount: bills.length,
                  itemBuilder: (context, index) =>
                    BillCard(bill: bills[index])
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}