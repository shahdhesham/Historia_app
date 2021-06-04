import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_gp/models/monument.dart';
import 'package:ui_gp/providers/auth.dart';
import 'package:ui_gp/screens/monumentDetail.dart';

class MonumentItem extends StatelessWidget {
  static const routeName = 'monument-item';
  @override
  Widget build(BuildContext context) {
    final monument = Provider.of<Monument>(context, listen: false);

    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            print(monument.monumentName);
            Navigator.pushNamed(
              context,
              MonumentDetail.routeName,
              arguments: monument.id,
            );
          },
          child: Image.network(
            monument.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black,
          leading: Consumer<Monument>(
            builder: (ctx, monument, _) => IconButton(
              icon: Icon(
                monument.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Colors.amber,
              onPressed: () {
                monument.toggleFavoriteStatus(authData.token, authData.userId);
              },
            ),
          ),
          title: Text(
            monument.monumentName,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
