import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List pokedex = [];
  final fontNormal = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24);
  final fontCaption = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
  final fontChip = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
  @override
  void initState() {
    super.initState();
    getPokeJson();
    if (mounted) {
      getPokeJson();
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(188, 255, 0, 0),
          Color.fromARGB(255, 0, 0, 0)
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Stack(children: [
          Positioned(
              top: -50,
              right: -50,
              child: Image.asset("assets/pokeball.png",
                  width: 170, fit: BoxFit.fitWidth)),
          const Positioned(
              top: 60,
              left: 16,
              child: Text(
                "Pokedex",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 38),
              )),
          Positioned(
              top: 110,
              bottom: 0,
              width: deviceWidth,
              child: Column(
                children: [
                  pokedex != null
                      ? Expanded(
                          child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 3 / 4),
                          itemCount: pokedex.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: InkWell(
                                  child: SafeArea(
                                child: Stack(children: [
                                  Container(
                                    width: deviceWidth,
                                    margin: const EdgeInsets.only(top: 80),
                                    decoration: const BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: 120,
                                            left: 8,
                                            bottom: 0,
                                            child: Text(pokedex[index]['name'],
                                                style: fontNormal)),
                                        Positioned(
                                            top: 142,
                                            left: 8,
                                            bottom: 0,
                                            child: Text(
                                              pokedex[index]['type'][0],
                                              style: fontChip,
                                            )),
                                        Positioned(
                                            bottom: 2,
                                            right: 8,
                                            child: Text(
                                              pokedex[index]['num'],
                                              style: fontCaption,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: CachedNetworkImage(
                                      imageUrl: pokedex[index]["img"],
                                      height: 200,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                ]),
                              )),
                            );
                          },
                        ))
                      : const Center(child: CircularProgressIndicator())
                ],
              ))
        ]),
      ),
    );
  }

  void getPokeJson() {
    ///Biuni/PokemonGO-Pokedex/master/pokedex.json
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");

    http.get(url).then((value) {
      var data = jsonDecode(value.body);
      pokedex = data["pokemon"];
      setState(() {});
      if (kDebugMode) {
        print(pokedex);
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
    });
  }
}
