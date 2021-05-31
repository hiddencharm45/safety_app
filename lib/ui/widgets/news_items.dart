import 'dart:ui';

import 'package:flutter/material.dart';

//import 'package:safety_app/ui/model/news.dart';
//import '../screens/home_screen.dart';

class NewsItem extends StatefulWidget {
  final title;
  final imageUrl;
  final description;
  final id;
  NewsItem(this.title, this.imageUrl, this.description, this.id);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  double _width;

  void _selectNews(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (_) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(ctx).pop(),
              child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  initialChildSize: 0.8,
                  minChildSize: 0.5,
                  // maxChildSize: 0.95,
                  builder: (_, controller) => Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    // padding: EdgeInsets.all(2),
                    child: ListView(
                      controller: controller,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                widget.imageUrl,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              )),
                        ),
                        // Image.asset(imageUrl),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontSize: 24),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    widget.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )),

                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.pinkAccent),
                            child: Text("Close"),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => _selectNews(context),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Container(
            height: 120,
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: Container(
                            width: _width * 0.3,
                            height: 100,
                            //color: Colors.black.withOpacity(0.9),
                            child: Image.asset(
                              widget.imageUrl,
                              //color: Colors.blue,
                              //colorBlendMode: BlendMode.colorBurn,

                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  //color: Colors.black,
                  width: _width * 0.5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
                        child: Row(
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // this will show dots(...) after 2 lines
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  text: widget.description,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
