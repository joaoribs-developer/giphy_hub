import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map git;


  GifPage(this.git);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (){
              Share.share(git["images"]["fixed_height"]["url"]);
            }, icon: Icon(Icons.share,))
          ],
          backgroundColor: Colors.black,
          title: Image.network(
              "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        ),
        backgroundColor: Colors.black,
        body: mainContent()
    );
  }


 Widget mainContent() {
    return Center(
      child: Container(
        height: 400,
          child: Image.network(git["images"]["fixed_height"]["url"], fit: BoxFit.cover,)),
    );
 }

}
