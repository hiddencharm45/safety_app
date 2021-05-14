import 'package:flutter/material.dart';
//import 'package:safety_app/ui/model/news.dart';
//import '../screens/home_screen.dart';

class NewsItem extends StatelessWidget {
  final title;
  final imageUrl;
  final description;
  NewsItem(this.title, this.imageUrl, this.description);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => null,
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
                            width: 130,
                            height: 100,
                            //color: Colors.black.withOpacity(0.9),
                            child: Image.asset(
                              imageUrl,
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
                  width: 210,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
                        child: Row(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
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
                                  text: description,
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
