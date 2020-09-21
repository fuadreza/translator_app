import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator_app/bloc/translate_bloc.dart';
import 'package:translator_app/bloc/translate_event.dart';
import 'package:translator_app/bloc/translate_state.dart';
import 'package:translator_app/services/translate_repo.dart';

/*This App Created by Fuad Reza Pahlevi*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TranslateBloc _bloc;

  String _text;

  @override
  void initState() {
    super.initState();
    _bloc = TranslateBloc(TranslateRepo());
  }

  @override
  Widget build(BuildContext context) {
    _bloc.add(GetDataEvent('id', 'Morning'));
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, data) {
            if (data is HasDataState) {
              var list = data.data;
              List<Widget> listTranslated = [];
              for (var item in list) {
                listTranslated.add(textTranslated(item));
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'English to Indonesian Translator',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 36),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 20.0, left: 24.0, right: 24.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'What to translate'),
                          initialValue: 'Morning',
                          onChanged: (value) {
                            setState(() {
                              _text = value;
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () => _bloc.add(GetDataEvent('id', _text)),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          child: Text(
                            'Translate',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: listTranslated),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text('Not Translated'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget textTranslated(Sentence sentence) {
    return Column(
      children: [
        Text('Translated to:'),
        SizedBox(
          height: 10.0,
        ),
        Text(
          sentence.trans,
          style: TextStyle(color: Colors.blueAccent, fontSize: 30.0),
        ),
      ],
    );
  }
}
