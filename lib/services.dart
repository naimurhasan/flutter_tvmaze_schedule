import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './Models/Episode.dart';
import 'constants.dart';

Future<List<Episode>> fetchEpisodes() async{
  final response = await http.get(
    kApiUri,
    headers: {
      'Accept' : 'application/json'
    }
  );

  if( response.statusCode == 200 )
  {
    return parseEpisodes(response.body);
  }else {
    throw Exception("Unable to fetch episodes from the REST API");
  }
}

List<Episode> parseEpisodes(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed.map<Episode>((json) => Episode.fromJson(json)).toList();
}
