
import 'package:eloyalty2/provider/auth.dart';
import 'package:eloyalty2/screens/auth_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cards_overview_screen.dart';
import './screens/card_detail_screen.dart';
import './provider/cards.dart';
import './screens/user_cards_screen.dart';
import './screens/edit_card_screen.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider.value(
        value: Auth(),
    ),
    ChangeNotifierProxyProvider<Auth, Cardls>(
    builder: (ctx, auth, previousCards) => Cardls(
     auth.token,
     auth.userId,
     previousCards == null ? [] : previousCards.items,
    ),
    ),

    ],

    child: Consumer<Auth>(
    builder: (ctx, auth, _) => MaterialApp(
          title: 'ELOYALTY',
          theme: ThemeData(
           // primarySwatch: Colors.lightBlue,
            accentColor: Colors.deepOrange,
            primaryColor: Colors.cyan[600],
            brightness: Brightness.dark,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? Home() : AuthScreen(),
          routes: {
            CardDetailScreen.routeName: (ctx) => CardDetailScreen(),
            UserCardsScreen.routeName: (ctx) => UserCardsScreen(),
            EditCardScreen.routeName: (ctx) => EditCardScreen(),
          }
          ),
    ),
    );
  }
}
