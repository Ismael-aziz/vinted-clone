// article_screen.dart
import 'package:flutter/material.dart';
import 'article.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  ArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Article',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: 300,
              child: Image.asset("article.imageUrl"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.seller,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text(
                        '${article.rating} (${article.reviews})',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    article.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.size,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' ${article.newPrice}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.teal),
                      ),
                      if (article.oldPrice.isNotEmpty)
                        Text(
                          ' ${article.oldPrice}',
                          style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.favorite_border, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('${article.likes}'),
                    ],
                  ),
                  SizedBox(height: 200),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       ElevatedButton(
                        onPressed: () {},
                        child: Text('Faire une offre', style: TextStyle(color: Colors.teal)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Acheter', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          textStyle: TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
