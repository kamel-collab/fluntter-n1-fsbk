import 'package:first/screens/detail_screen.dart';
import 'package:first/screens/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final VoidCallback? onTap;
  final Product product;
  const ProductCard({super.key, this.onTap, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  //
  String aa = "clicke me";
  @override
  Widget build(BuildContext context) {
    print("je suis ton pere");
    return InkWell(
      onTap: () {
        setState(() {
          aa = "c bon";
        });
        /* Navigator.pushNamed(
          context,
          DetailScreen.route,
          arguments: {
            "name": product.name,
            "imageUrl": product.imageUrl,
            "price": product.price,
          },
        );*/
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
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(top: 8, right: 8, child: Favorit(isFavorit: false)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),

                  Text(
                    "${widget.product.price} ${aa} da",
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

class Favorit extends StatefulWidget {
  bool isFavorit;
  Favorit({super.key, required this.isFavorit});

  @override
  State<Favorit> createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  @override
  Widget build(BuildContext context) {
    print("im your favorite");
    return InkWell(
      onTap: () {
        print('tapped');
        setState(() {
          widget.isFavorit = !widget.isFavorit;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(6.0),
        child: widget.isFavorit
            ? Icon(Icons.favorite, color: Colors.yellow)
            : Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }
}
