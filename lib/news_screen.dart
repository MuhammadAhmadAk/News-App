// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/Models/newsmodel.dart';
import 'package:news/detail.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<Newsmodel> getNewsapi() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a9ce15f1212e4036a79dff63f0a2d664'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return Newsmodel.fromJson(data);
    } else {
      return Newsmodel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getNewsapi(),
              builder:
                  (BuildContext context, AsyncSnapshot<Newsmodel> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (BuildContext context, int index) {
                    //var auther =snapshot.data?.articles![index].author.toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 9),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetail(
                                      title: snapshot
                                          .data?.articles![index].title
                                          .toString(),
                                      Image: snapshot
                                          .data?.articles![index].urlToImage
                                          .toString(),
                                      contentData: snapshot
                                          .data?.articles![index].content
                                          .toString())));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              border: Border.all(color: Colors.blueGrey)),
                          child: Column(
                            children: [
                              Image.network(
                                snapshot.data!.articles![index].urlToImage
                                    .toString(),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              Text(
                                snapshot.data!.articles![index].title
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Author : ' +
                                        snapshot.data!.articles![index].author
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
