import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:giphy_hub/Network/HttpBluider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? parametroQuery;
  int ofSet = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
      ),
      backgroundColor: Colors.black,
      body: mainScreen(),
    );
  }

  Widget mainScreen() {
    return Column(
      children: [
        barraDePesquisa(),
        futureBluider()
      ],
    );
  }

  Widget barraDePesquisa() {
    final TextEditingController controler = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
                color: Colors.blueGrey,
                width: 2,
                style: BorderStyle.solid
            )
        ),
        color: Colors.black,
        child: TextField(
          onSubmitted: (t) {
            setState((){
              parametroQuery = controler.text;
              }
            );},
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              suffixIcon: IconButton(
                  padding: const EdgeInsets.only(right: 5),
                  icon: const Icon(
                    Icons.search_rounded, size: 45, color: Colors.blueGrey,),
                  onPressed: () {
                    if(parametroQuery!=null){
                      setState((){
                        parametroQuery = controler.text;
                      }
                    );}
                  }
              ),
              hintText: "Digite para pesquisar...",
              hintStyle: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 28
              )
          ),
          style: const TextStyle(
              fontSize: 50,
              color: Colors.blueGrey
          ),
          controller: controler,
        ),
      ),
    );
  }

  Widget futureBluider() {
    return FutureBuilder<Map>(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Container(
              height: 200,
              width: 200,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                strokeWidth: 5.0,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Container();
            } else {
              return gifListFactory(context, snapshot);
            }
        }
      },
      future: getDataGeneric(parametroQuery, ofSet),
    );
  }

  Widget gifListFactory(BuildContext context, AsyncSnapshot? snapshot) {
    List<dynamic> list = snapshot?.data["data"];
    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
          itemCount: list.length+1,
          itemBuilder: (context, index) {
            if(index != list.length) {
              return GestureDetector(
              child: Image.network(
                snapshot?.data["data"][index]["images"]["fixed_height"]["url"] ??"",
                fit: BoxFit.cover,),
            );
            }else{
              return IconButton(
                  onPressed: (){
                setState((){
                  if((list.length+1)%2 == 0) {
                    ofSet+=19;
                  }else {
                    ofSet+=21;
                  }
                });
              }, icon:const Icon(Icons.add, size: 80, color: Colors.white,));
            }
          }
      ),
    );
  }
}
