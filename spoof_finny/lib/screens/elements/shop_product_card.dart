import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/shop_system/shop_product.dart';
import 'package:spoof_finny/models/user_info.dart';

class ShopProductCard extends StatefulWidget {
  final Function(String productName, int count, UserInfo userInfo) buy;
  final ShopProduct product;

  const ShopProductCard({
    super.key, 
    required this.product,
    required this.buy,
  });

  @override
  State<ShopProductCard> createState() => _ShopProductCardState();
}

class _ShopProductCardState extends State<ShopProductCard> {
  final ExpansibleController _controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          widget.buy(widget.product.item.name, 1, GameState.instance.userInfo);
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  spacing: 5,
                  children: [
                    Center(
                      child: Text(
                        widget.product.item.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/${widget.product.item.assetsFolder}',
                          fit: BoxFit.contain,
                          width: 75,
                          height: 75,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ValueListenableBuilder<int>(
                              valueListenable: widget.product.stockCountNotifier,
                              builder: (BuildContext context, int value, Widget? child) { 
                                  return Text(
                                    widget.product.stockCount.toString(),
                                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                  );
                              },
                            )
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.product.price % 1 == 0 ? widget.product.price.toInt() : widget.product.price.toStringAsFixed(2)}🪙',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}