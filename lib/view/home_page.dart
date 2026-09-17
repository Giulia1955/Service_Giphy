import 'package:flutter/material.dart';
import 'package:api_gif/service/giphy_service.dart';
import 'package:api_gif/view/giphy_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search = '';
  int _offset = 0;
  bool _loadingMore = false;
  bool _isSearching = false;
  List _gifData = [];

  final GiphyService _giphyService = GiphyService();

  @override
  void initState() {
    super.initState();
    _loadGifs();
  }

  void _loadGifs() async {
    setState(() {
      _loadingMore = true;
    });

    var newGifs = await _giphyService.getGifs(_search, _offset);

    setState(() {
      _gifData.addAll(newGifs['data']);
      _loadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
          "https://developers.giphy.com/branch/master/"
          "static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif",
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search GIFs",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                setState(() {
                  _search = value;
                  _offset = 0;
                  _gifData.clear();
                  _loadGifs();
                });
              },
            ),
          ), // Adicionada vírgula aqui
          Expanded(
            child: _gifData.isEmpty && !_loadingMore && !_isSearching
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ),
                  )
                : _createGifTable(),
          ),
        ],
      ),
    );
  }

  Widget _createGifTable() {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _gifData.length + (_loadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _gifData.length) {
          var gif = _gifData[index];
          var gifUrl = gif['images']['original']['url'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GiphyPage(gif),
                ),
              );
            }, // Fechamento do onTap
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 50.0),
                  Text(
                    "Load More",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ],
              ),
              onTap: !_loadingMore
                  ? () {
                      setState(() {
                        _loadingMore = true;
                        _offset += 25;
                      });
                      _loadGifs();
                    }
                  : null,
            ),
          );
        }
      },
    ); // Fechamento do GridView.builder
  }
}