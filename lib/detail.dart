// ignore_for_file: avoid_unnecessary_containers, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final title;
  final Image;
  final contentData;
  final pubDate;
  final authorName;
  const NewsDetail(
      {super.key,
      required this.title,
      required this.Image,
      required this.contentData,
      this.pubDate,
      this.authorName});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Container(
            child: Image.network(
              widget.Image,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(widget.contentData,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        )
      ]),
    );
  }
}
