import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/items/food.dart';
import 'package:spoof_finny/screens/elements/food_card.dart';

class FridgeScreen extends StatefulWidget{
  const FridgeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen>{
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Холодильник', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                IconButton(
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight * 0.2, maxHeight: screenHeight * 0.7),
              child: SingleChildScrollView(
              padding: const EdgeInsets.all(5.0),
              child: ListenableBuilder(
                listenable: GameState.instance.userInfo.inventory,
                builder: (context, child) {
                  final foodList = GameState.instance.userInfo.inventory.items.whereType<Food>().toList();
                  if (foodList.isEmpty) {
                    return const SizedBox(
                      height: 100,
                      child: Center(child: Text('Холодильник пуст 😿', style: TextStyle(fontSize: 30),)),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5.0),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.49,
                    ),
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      return FoodCard(food: foodList[index]);
                    },
                  );
                },
              ),
            ),
            )
          ],
        )
      ),
    );
  }
}