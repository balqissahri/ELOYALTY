import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cards.dart';

class CardDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final cardId =
    ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedCard = Provider.of<Cardls>(
      context,
      listen: false,
    ).findById(cardId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCard.cname),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: 300,
                height: 300,
                margin: EdgeInsets.only(
                  top: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                /* child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),*/

              ),



              /*child: Image.network(
                loadedCard.imageUrl,
                fit: BoxFit.cover,
              ),*/


            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedCard.company,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}