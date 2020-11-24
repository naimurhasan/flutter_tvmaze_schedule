import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import '../Models/Episode.dart';

class ShowDetailsPage extends StatelessWidget {
  final Episode episode;
  final List<Color> gradientBg;

  ShowDetailsPage({Key key, this.episode, this.gradientBg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'background-' + episode.id.toString(),
            child: DecoratedBox(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientBg,
              ),
            )),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(5.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      fillColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      constraints: BoxConstraints.tightFor(),
                      shape: CircleBorder(),
                    ),
                  ),
                  Hero(
                    tag: 'title-' + episode.id.toString(),
                    child: Text(
                      episode.show.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Hero(
                    tag: 'image-' + episode.id.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        episode.show.image == null
                            ? 'https://i.ibb.co/QPgh6Q5/no-image.jpg'
                            : episode.show.image.medium,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.add_comment),
                                SizedBox(width: 5.0),
                                Text(
                                  'Overview',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: episode.show.rating.average != null ? Colors.yellow : Colors.transparent,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                    episode.show.rating.average == null
                                        ? ''
                                        : episode.show.rating.average
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 20)),
                              ],
                            )
                          ],
                        ),
                        Html(
                            data: episode.summary != null
                                ? episode
                                .summary
                                .toString()
                                : 'No description available yet.',
                            style: {
                              '*': Style(
                                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 0)
                              ),
                              'p': Style(
                                fontSize: FontSize.large
                              )
                            }
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.watch),
                                SizedBox(width: 5.0),
                                Text(
                                  'Air Time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(),
                                ),
                              ],
                            ),
                            Text(
                              episode.airtimestr,
                              style: TextStyle( fontSize: 20)
                            )
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              color: Colors.amber,
                                child:
                                  Padding(padding: EdgeInsets.all(5.0),child: Text('Days: '+episode.daysCommaSeparated)),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
