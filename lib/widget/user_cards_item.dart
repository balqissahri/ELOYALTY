import 'package:eloyalty2/provider/cards.dart';
import 'package:eloyalty2/screens/edit_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCardItem extends StatelessWidget {
  final String cname;
  final String id;
  //final String company;

  UserCardItem(this.cname, this.id);

  @override
  Widget build(BuildContext context) {
    //HTTP
    final scaffold = Scaffold.of(context);

    return ListTile(
      title: Text(cname),
      leading: CircleAvatar(
        //backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditCardScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: ()
              //before http
              /*{
                Provider.of<Cardls>(context, listen: false).deleteCard(id);
              },
              color: Theme.of(context).errorColor,*/
              //http
              async {
                try {
                  await Provider.of<Cardls>(context, listen: false)
                      .deleteCard(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting failed!', textAlign: TextAlign.center,),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,

            ),
          ],
        ),
      ),
    );
  }
}