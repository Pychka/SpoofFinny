import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/screens/elements/shop_product_card.dart';

class ShopScreen extends StatefulWidget{
  const ShopScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>{
  @override
  Widget build(BuildContext context) {
    final shop = GameState.instance.userInfo.shopManager.currentShop;
    if(shop == null){
      return Text('Такого магазина нет', style: TextStyle(fontSize: 30),);
    }
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Card(
                      color: Color(0xA0FFFFFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: ValueListenableBuilder<double>(
                          valueListenable: GameState.instance.userInfo.moneyManager.wallet.moneyNotifier,
                          builder: (context, value, child) => Text(
                              "${value % 1 == 0 ? value.toInt() : value.toStringAsFixed(2)}🪙",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                      )
                    ),
                    Expanded(
                      child: Text(
                        shop.name,
                        style: TextStyle(fontSize: 20), textAlign: TextAlign.center,
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: screenHeight * 0.2, maxHeight: screenHeight * 0.7),
                  child: ListenableBuilder(
                    listenable: GameState.instance.userInfo.statManager,
                    builder: (context, child) {
                      if(shop.productsInStock.isEmpty){
                        return const SizedBox(
                          height: 100,
                          child: Center(child: Text('Товаров нет 😿', style: TextStyle(fontSize: 30),)),
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
                          childAspectRatio: 0.7,
                        ),
                        itemCount: shop.productsInStock.length,
                        itemBuilder: (context, index) {
                          return ShopProductCard(
                            product: shop.productsInStock[index],
                            buy: shop.buy,
                          );
                        },
                      );
                    },
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