import 'package:eloyalty2/provider/cards.dart';
import 'package:eloyalty2/screens/qr_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/card.dart';

class EditCardScreen extends StatefulWidget {
  static const routeName = '/edit-card';

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final _companyFocusNode = FocusNode();
  final _edateFocusNode = FocusNode();
  // final _imageUrlController = TextEditingController();
  // final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedCard = Cardl(
    id: null,
    cname: '',
    company: '',
    //edate:'',
    //imageUrl: '',
  );
  //submit
  var _initValues = {
    'cname': '',
    'company': '',
   // 'edate':'',
  };
  var _isInit = true;

  //HTTP
  var _isLoading = false;

  @override
  void initState() {
   // _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  //submit
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final cardId = ModalRoute.of(context).settings.arguments as String;
      if (cardId != null) {
        _editedCard =
            Provider.of<Cardls>(context, listen: false).findById(cardId);
        _initValues = {
          'cname': _editedCard.cname,
          'company': _editedCard.company,
          //edate : _editedCard.edate,
          // 'imageUrl': _editedCard.imageUrl,
         // 'imageUrl': '',
        };
       // _imageUrlController.text = _editedCard.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  void dispose() {
    //_imageUrlFocusNode.removeListener(_updateImageUrl);
    _companyFocusNode.dispose();
    _edateFocusNode.dispose();
    //_imageUrlController.dispose();
    // _imageUrlFocusNode.dispose();
    super.dispose();
  }


//HTTP add Future<..> ...async
  Future<void> _saveForm() async{
    //validate
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    //HTTP load
    setState(() {
      _isLoading = true;
    });
    //submit
    if (_editedCard.id != null) {
      Provider.of<Cardls>(context, listen: false)
          .updateCard(_editedCard.id, _editedCard);
    } else {
      //HTTP add try await
      //Provider.of<Cardls>(context, listen: false).addCard(_editedCard);
      // }
      try {
        await Provider.of<Cardls>(context, listen: false)
            .addCard(_editedCard);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) =>
              AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    //endHTTP
      Navigator.of(context).pop();
    }
//Before submit
/*print(_editedCard.cname);
    print(_editedCard.company);
    // print(_editedCard.imageUrl);
 */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),

      //HTTP
      //body: Padding(
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          //HTTP end
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['cname'],
                decoration: InputDecoration(labelText: 'Card Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_companyFocusNode);
                },
                //validation
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCard = Cardl(
                    cname: value,
                    company: _editedCard.company,
                   // edate: _editedCard.edate,
                    // imageUrl: _editedCard.imageUrl,
                    id: _editedCard.id,
                      isFavorite: _editedCard.isFavorite
                  );
                },
              ),

              TextFormField(
                initialValue: _initValues['company'],
                decoration: InputDecoration(labelText: 'Company Name'),
                textInputAction: TextInputAction.next,
                focusNode: _companyFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(_edateFocusNode);
                },
                //validation
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCard = Cardl(
                    cname: _editedCard.cname,
                    company: value,
                    //  edate: _editedCard.edate,
                    //imageUrl: _editedCard.imageUrl,
                      id: _editedCard.id,
                      isFavorite: _editedCard.isFavorite
                  );
                },
              ),



              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
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

                ],
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

              RaisedButton(
              child: Text('Generate QR code',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
          color: Colors.orangeAccent,

          onPressed:(){
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=> GeneratePage()),
            );
          }
      ),
      ],
    ),


            ],
          ),
        ),
      ),
    );
  }
}
