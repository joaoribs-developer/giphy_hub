import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Map> getDataGeneric(String? parametroQuery, [int ofSet = 19]) async{
  final trending = Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=veebiAV9jW3w858F6VAjLp9mQG8pZi5E&limit=${ofSet.toString()}&rating=g");
  final search = Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=veebiAV9jW3w858F6VAjLp9mQG8pZi5E&q=$parametroQuery&limit=${ofSet.toString()}&offset=0&rating=g&lang=en");
  final request;
  if(parametroQuery == null || parametroQuery.isEmpty) {
    request =  await http.get(trending);
  }else {
    request =  await http.get(search);
  };
    http.Response response = request;
    return await json.decode(response.body);
  }
//