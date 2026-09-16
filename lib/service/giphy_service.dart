import 'package:http/http.dart' as http;
import 'dart:convert';

const String _key = 'BTZVslOLqa3nezCw8pF8v2FUiIh2hUzw';

class GiphyService {
  Future<Map> getGifs(String _search, int _offset) async {
    http.Response response;
    if(_search == null || _search.isEmpty) {
      response = await http.get(Uri.parse('https://api.giphy.com/v1/gifs/trending?api_key=$_key&limit=20&rating=g'));
    } else {
      response = await http.get(Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=$_key&q=$_search&limit=19&offset=$_offset&rating=g&lang=en'));
    }
    return json.decode(response.body);
  }
}