import 'package:eloyalty2/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/card_detail_screen.dart';
import '../provider/card.dart';


class CardItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final card = Provider.of<Cardl>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              CardDetailScreen.routeName,
              arguments: card.id,
            );
          },

        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Cardl>(
            builder: (ctx, card, _) => IconButton(
              icon: Icon(
                card.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                card.toggleFavoriteStatus(
                  authData.token,
                  authData.userId,);
              },
            ),
          ),
          title: Text(
            card.cname,
            textAlign: TextAlign.center,
          ),

        ),
      ),
    );
  }
}