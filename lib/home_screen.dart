import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'article.dart';
import 'article_screen.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<String> likedArticles = []; // Liste des IDs des articles likés par l'utilisateur
  TextEditingController searchController = TextEditingController(); // Contrôleur pour le champ de recherche
  String searchQuery = ''; // Variable pour stocker le texte de recherche

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: searchController, // Contrôleur de texte pour le champ de recherche
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase(); // Mettre à jour la variable de recherche
              });
            },
            decoration: InputDecoration(
              hintText: 'Rechercher un article par titre',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          Container(
            color: Color(0xFF006E78),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Façonne Vinted à ton image !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Trouve les articles qui te correspondent le mieux. Ajoute ta taille et ta pointure, ainsi que tes marques préférées.',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Personnaliser', style: TextStyle(color: Color(0xFF006E78))),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/back1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                height: 200,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.verified, color: Color(0xFF006E78)),
                        SizedBox(width: 8),
                        Text('Vérification de l\'article', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Achète des pièces vérifiées par nos experts',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF006E78),
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Explorer les articles de créateur', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fil d\'actu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('articles').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final articles = snapshot.data!.docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return Article(
                          title: data['title'] as String,
                          size: data['size'] as String,
                          oldPrice: data['oldPrice'] as int,
                          newPrice: data['newPrice'] as int,
                          likes: data['likes'] as int,
                          seller: data['seller'] as String,
                          reviews: data['reviews'] as int,
                          rating: data['rating'] as int,
                          photos: List<String>.from(data['photos']), // Convertir la liste de photos
                          description: data['description'] as String,
                          brand: data['brand'] as String,
                          category: data['category'] as String,
                          condition: data['condition'] as String,
                          id: doc.id, // Ajout de l'id du document Firestore
                        );
                      }).toList();

                      // Filtrer les articles par titre
                      final filteredArticles = articles.where((article) =>
                          article.title.toLowerCase().contains(searchQuery)
                      ).toList();

                      if (filteredArticles.isEmpty) {
                        return Center(
                          child: Text('Aucun article en vente'),
                        );
                      }

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.63,
                        ),
                        itemCount: filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = filteredArticles[index];
                          final isLiked = likedArticles.contains(article.id);

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
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(article.photos[0]), // Afficher la première photo
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 8,
                                        bottom: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isLiked) {
                                              // Déjà liké, donc annuler le like
                                              FirebaseFirestore.instance.collection('articles').doc(article.id).update({
                                                'likes': article.likes - 1,
                                              });
                                              setState(() {
                                                likedArticles.remove(article.id);
                                              });
                                            } else {
                                              // Pas encore liké, ajouter un like
                                              FirebaseFirestore.instance.collection('articles').doc(article.id).update({
                                                'likes': article.likes + 1,
                                              });
                                              setState(() {
                                                likedArticles.add(article.id);
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  isLiked ? Icons.favorite : Icons.favorite_border,
                                                  size: 16,
                                                  color: isLiked ? Colors.red : Colors.grey,
                                                ),
                                                const SizedBox(width: 4),
                                                Text('${article.likes}', style: const TextStyle(fontSize: 12)),
                                              ],
                                            ),
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
                                        Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text(article.size),
                                        const SizedBox(height: 8),
                                        Text('${article.oldPrice}', style: const TextStyle(decoration: TextDecoration.lineThrough)),
                                        Text('${article.newPrice}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006E78))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
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
