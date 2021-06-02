import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import './card.dart';

class Cardls with ChangeNotifier {
  List<Cardl> _items = [
   /* Cardl(
      id: 'p1',
      cname: 'KK Value',
      company: 'KK Mart',
      //imageUrl:
     // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Cardl(
      id: 'p2',
      cname: 'TF Value',
      company: 'TF Mart',
      //imageUrl:
      // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Cardl(
      id: 'p3',
      cname: 'Watson',
      company: 'Watson',
      //imageUrl:
      // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Cardl(
      id: 'p4',
      cname: 'Beauty Card',
      company: 'Sephora',
      //imageUrl:
      // 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),*/
  ];
  // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;

  Cardls(this.authToken, this.userId, this._items);

  List<Cardl> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((cardItem) => cardItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Cardl> get favoriteItems {
    return _items.where((cardItem) => cardItem.isFavorite).toList();
  }

  Cardl findById(String id) {
    return _items.firstWhere((card) => card.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetCards([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://eloyalty2-default-rtdb.asia-southeast1.firebasedatabase.app/cards.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
      'https://eloyalty2-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Cardl> loadedCards = [];
      extractedData.forEach((cardId, cardData) {
        loadedCards.add(Cardl(
          id: cardId,
          cname: cardData['cname'],
          company: cardData['company'],
         // edate: cardData['edate'],
          isFavorite: favoriteData == null ? false : favoriteData[cardId] ?? false,
          //imageUrl: cardData['imageUrl'],
        ));
      });
      _items = loadedCards;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addCard(Cardl card) async {
    final url =
    'https://eloyalty2-default-rtdb.asia-southeast1.firebasedatabase.app/cards.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'cname': card.cname,
          'company': card.company,
          //'edate' : card.edate,
          //'imageUrl': card.imageUrl,
          'isFavorite': card.isFavorite,
        }),
      );
    // _items.add(value);
    final newCard = Cardl(
      cname: card.cname,
      //edate: card.edate,
      company: card.company,
      id: json.decode(response.body)['name'],
    );
    _items.add(newCard);
    // _items.insert(0, newCard); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateCard(String id, Cardl newCard) async {
    final cardIndex = _items.indexWhere((card) => card.id == id);
    if (cardIndex >= 0) {
      final url =
          'https://eloyalty2-default-rtdb.asia-southeast1.firebasedatabase.app/cards/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'cname': newCard.cname,
           // 'edate': newCard.edate,
            'company': newCard.company,
            //'imageUrl': newCard.imageUrl,
          }));
      _items[cardIndex] = newCard;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteCard(String id) async {
    final url =
        'https://eloyalty2-default-rtdb.asia-southeast1.firebasedatabase.app/cards/$id.json?auth=$authToken';
    final existingCardIndex = _items.indexWhere((card) => card.id == id);
    var existingCard = _items[existingCardIndex];
    _items.removeAt(existingCardIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingCardIndex, existingCard);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingCard = null;
  }
}