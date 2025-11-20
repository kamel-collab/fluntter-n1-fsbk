import 'package:first/data.dart';
import 'package:first/screens/product.dart';
import 'package:first/screens/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ecomm APP', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 4.0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProductsFromApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "une erreur c'est produit veuilez try again ${snapshot.error}",
              ),
            );
          }
          if (snapshot.data!.isEmpty || !snapshot.hasData) {
            return Center(child: Text("aucun produit disponible"));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth = 180;
              int crossAxisCount = (constraints.maxWidth / cardWidth).floor();
              if (crossAxisCount < 2) {
                crossAxisCount = 2;
              }
              final products = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: Product(
                      name: product['name'],
                      imageUrl: product['imageUrl'],
                      price: product['price'].toString(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),

      /* 
      */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.deepOrange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
