import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cached Images App',

      theme: ThemeData(primarySwatch: Colors.blue),

      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное меню'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagesScreen()),
            ),
            child: Text('Показать изображения'),
          ),
        ],
      ),
    );
  }
}

class ImagesScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://habrastorage.org/r/w1560/webt/uc/3h/x2/uc3hx2hqnyqpzk40swy1kpfh45o.png',
    'https://habrastorage.org/r/w1560/webt/qi/vw/ea/qivweahk3h2d3v2kvet-8mzldpy.jpeg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1Olsnm89VJQZmcikSyiv8rV16H2sZznY3tEEyN2lsA-Dz7oaGUnQp9RpTOhE&s',
    'https://habrastorage.org/storage2/9e9/161/21c/9e916121c094fa78d333fe91305f37ff.jpg',
    'https://habrastorage.org/webt/ns/fk/uq/nsfkuqrvksg0k_pa2mh--wn2qb4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сетевые изображения'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Изображение ${index + 1}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
