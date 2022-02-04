import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../helpers/helper.dart';
import 'dart:convert';
import '../helpers/custom_trace.dart';
import '../models/auto_suggestion.dart';

void setRecentSearch(search) async {
  if (search != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('recent_search', search);
  }
}

Future<String> getRecentSearch() async {
  String _search = "";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('recent_search')) {
    _search = prefs.get('recent_search').toString();
  }
  return _search;
}

Future<Stream<AutoSuggestion>> getAutosuggestion(String searchText) async {
  Uri uri = Helper.getUri('api/auto_suggestion/');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = '$searchText';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) => AutoSuggestion.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new AutoSuggestion.fromJSON({}));
  }
}
