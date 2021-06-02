import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cards.dart';
import './card_item.dart';

class CardsGrid extends StatelessWidget {
  final bool showFavs;

  CardsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final cardsData = Provider.of<Cardls>(context);
    final cards = showFavs ? cardsData.favoriteItems : cardsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: cards.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => cards[i],
        value: cards[i],
        child: CardItem(
          // cards[i].id,
          // cards[i].cname,
          // cards[i].imageUrl,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}