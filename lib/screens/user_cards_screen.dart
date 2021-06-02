import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cards.dart';
import '../widget/user_cards_item.dart';
import '../widget/app_drawer.dart';
import './edit_card_screen.dart';

class UserCardsScreen extends StatelessWidget {
  static const routeName = '/user-cards';

  //http
  Future<void> _refreshCards(BuildContext context) async {
    await Provider.of<Cardls>(context).fetchAndSetCards();
  }

  @override
  Widget build(BuildContext context) {
    final cardsData = Provider.of<Cardls>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cards'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditCardScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
    body: RefreshIndicator(
      onRefresh: () => _refreshCards(context),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: cardsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserCardItem(
                cardsData.items[i].cname,
                cardsData.items[i].id,
                //cardsData.items[i].company,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
