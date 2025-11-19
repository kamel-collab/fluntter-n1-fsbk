import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});
  static String route = "/detail_screen";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du produit avec une hauteur fixe
            Image.network(
              product['imageUrl'],
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),

            // Nom du produit
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${product['price']}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Prix du produit et Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    "46",
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(width: 16),

                  // Rating stars
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (4.9 ?? 0) ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 24,
                      );
                    }),
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
