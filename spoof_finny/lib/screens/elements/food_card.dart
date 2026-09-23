import 'package:flutter/material.dart';
import 'package:spoof_finny/models/items/item.dart';

class FoodCard extends StatefulWidget {
  final Item food;

  const FoodCard({
    super.key, 
    required this.food
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
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
          widget.food.use();
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: widget.food.countNotifier,
                        builder: (BuildContext context, int value, Widget? child) { 
                          return Text(
                            '${widget.food.name} x${widget.food.count}',
                            style: TextStyle(fontSize: 20),
                          );
                        },
                      )
                    ),
                    Image.asset(
                      'assets/images/${widget.food.assetsFolder}',
                      fit: BoxFit.contain,
                      width: 75,
                      height: 75,
                    ),
                    Text('Эффекты:'),
                    const Divider(),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.food.events.length,
                        padding: const EdgeInsets.symmetric(horizontal: 4.0), 
                        itemBuilder: (context, index) {
                          return Card(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: widget.food.events[index].getWidget(),
                                ),
                              )
                            );
                        },
                      ),
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