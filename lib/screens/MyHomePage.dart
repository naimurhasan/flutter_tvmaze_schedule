import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import '../Models/Episode.dart';
import '../services.dart';
import 'ShowDetailsPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Episode> episodes, filteredEpisodes;

  bool isSearching = false;
  final mTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEpisodes().then((data){
      setState(() {
        episodes = filteredEpisodes = data;
      });
    });
    mTextEditController.addListener(_filteredEpisodeController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: 'Search Show',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                controller: mTextEditController,
                autofocus: true,
              )
            : Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(isSearching ? Icons.cancel : Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    mTextEditController.text = "";
                  }
                });
              })
        ],
      ),
      body: filteredEpisodes == null ? Center(child: CircularProgressIndicator(),) : EpisodeListView(items: filteredEpisodes),
    );
  }

  void _filteredEpisodeController() {
    String query = mTextEditController.text;
    setState(() {
      filteredEpisodes = episodes.where((element) => element.show.name.toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  void dispose() {
    mTextEditController.dispose();
    super.dispose();
  }
}

/// Generate List View
class EpisodeListView extends StatelessWidget {
  List<Episode> items;

  EpisodeListView({this.items});

  @override
  Widget build(BuildContext context) {
    //back
    return ListView.builder(
        itemCount: items != null ? items.length : 0,
        itemBuilder: (BuildContext context, int position) {
          return Container(
            padding: EdgeInsets.all(5.0),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Hero(
                    tag: 'background-' + items[position].id.toString(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: gradientBackgrounds[position % 6],
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDetailsPage(
                                episode: items[position],
                                gradientBg: gradientBackgrounds[position % 6]),
                          ))
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                              width: 80.0,
                              child: Hero(
                                tag: 'image-' + items[position].id.toString(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    items[position].show.image == null
                                        ? 'https://i.ibb.co/QPgh6Q5/no-image.jpg'
                                        : items[position].show.image.medium,
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: 'title-' + items[position].id.toString(),
                                  child: Text(
                                    items[position].show.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                Html(
                                    data: items[position].summary != null
                                        ? items[position]
                                            .summary
                                            .toString()
                                            .truncateTo(55)
                                        : '',
                                    style: {
                                      '*': Style(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 0))
                                    }),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                        items[position].show.rating.average ==
                                                null
                                            ? 'Not rated yet.'
                                            : items[position]
                                                .show
                                                .rating
                                                .average
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 20)),
                                    Text(''),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

extension StringExtension on String {
  String truncateTo(int maxLenght) =>
      (this.length <= maxLenght) ? this : '${this.substring(0, maxLenght)}...';
}

List<List<Color>> gradientBackgrounds = [
  [Color(0xFF84c1f0), Color(0xFF7ea2f7)],
  [Color(0xFFd294ef), Color(0xFFc4337c)],
  [Color(0xFFf5b266), Color(0xFFf19f5a)],
  [Color(0xFFc87af2), Color(0xFF9880f7)],
  [Color(0xFF69e8cd), Color(0xFF59d9b9)],
  [Color(0xFFf16593), Color(0xFFe35d77)],
];
