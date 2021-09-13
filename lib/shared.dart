import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
//import 'package:newsapp/screens/webview.dart';

Widget newsAppItems(model, context) => InkWell(
      onTap: () {
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BusinessDescription())) ;
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${model['urlToImage']}"))),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${model['title']}  ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${model["publishedAt"]}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (model["author"] != null)
                        Text(
                          " author name : ${model["author"]}",
                          style: TextStyle(fontSize: 16, color: Colors.redAccent),
                          maxLines: 1,
                        ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 1,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 1,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
