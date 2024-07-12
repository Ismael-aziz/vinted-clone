// home_screen.dart
import 'package:flutter/material.dart';
import 'article.dart';
import 'article_screen.dart';

class HomeContent extends StatelessWidget {
  final List<Article> articles = [
    Article(
      imageUrl: 'assets/images/article1.jpg',
      title: 'Veste',
      size: 'L / 40 / 12',
      oldPrice: '1600 FCFA',
      newPrice: '1250 FCFA',
      likes: 11,
      seller: 'aziz',
      rating:4 ,
      reviews:54 ,
      isNew:true,
    ),
    Article(
      imageUrl: 'assets/images/article2.jpg',
      title: 'Zara',
      size: 'M / 38 / 10',
      oldPrice: '2000 FCFA',
      newPrice: '1800 FCFA',
      seller: 'aziz',
      rating:4 ,
      reviews: 64,
      isNew: true,
      likes: 22,
    ),
    Article(
      imageUrl: 'assets/images/article3.jpg',
      title: 'H&M',
      size: 'S / 36 / 8',
      oldPrice: '2500 FCFA',
      newPrice: '2000 FCFA',
      likes: 33,
      seller: 'aziz',
      rating: 6,
      reviews: 10,
      isNew:true ,
    ),
    Article(
      imageUrl: 'assets/images/article4.jpg',
      title: 'Pull over',
      size: 'S / 36 / 8',
      oldPrice: '3700 FCFA',
      newPrice: '3500 FCFA',
      likes: 136,
      seller: 'aziz',
      rating: 6,
      reviews: 15,
      isNew: true,
    ),
    Article(
      imageUrl: 'assets/images/article5.jpg',
      title: 'Chemisette',
      size: 'S / 36 / 8',
      oldPrice: '1000 FCFA',
      newPrice: '800 FCFA',
      likes: 47,
      seller: 'aziz',
      rating: 5,
      reviews:65 ,
      isNew: true,
    ),
    Article(
      imageUrl: 'assets/images/article6.jpg',
      title: 'Yeezy',
      size: 'eur / 39 - 46',
      oldPrice: '25.000 FCFA',
      newPrice: '23.000 FCFA',
      likes: 379,
      seller: 'aziz',
      rating: 6,
      reviews: 95,
      isNew: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher un article ou un membre',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.teal,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Façonne Vinted à ton image !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Trouve les articles qui te correspondent le mieux. Ajoute ta taille et ta pointure, ainsi que tes marques préférées.',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Personnaliser', style: TextStyle(color: Colors.teal)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/back1.jpg'), // Adjust your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                height: 200,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified, color: Colors.teal),
                        SizedBox(width: 8),
                        Text('Vérification de l\'article', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Achète des pièces vérifiées par nos experts',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Explorer les articles de créateur', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fil d\'actu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.67,
                  ),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleScreen(article: article),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(article.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.favorite_border, size: 16, color: Colors.grey),
                                        SizedBox(width: 4),
                                        Text('${article.likes}', style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(article.title, style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(article.size),
                                  SizedBox(height: 8),
                                  Text(article.oldPrice, style: TextStyle(decoration: TextDecoration.lineThrough)),
                                  Text(article.newPrice, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
