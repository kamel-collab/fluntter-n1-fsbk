import 'package:first/screens/detail_screen.dart';
import 'package:first/screens/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Product product;
  const ProductCard({super.key, this.onTap, required this.product});
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailScreen.route,
          arguments: {
            "name": product.name,
            "imageUrl": product.imageUrl,
            "price": product.price,
          },
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),

                  Text(
                    "${product.price} da",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 13),
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
