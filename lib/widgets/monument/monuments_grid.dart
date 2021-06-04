import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:ui_gp/providers/monuments.dart';

import 'monument-item.dart';

class MonumentsGrid extends StatelessWidget {
  MonumentsGrid(this.showFavs);
  final bool showFavs;

  @override
  Widget build(BuildContext context) {
    final storesData = provider.Provider.of<Monuments>(context);
    final stores = showFavs ? storesData.favoriteItems : storesData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: stores.length,
      itemBuilder: (ctx, i) => provider.ChangeNotifierProvider.value(
        value: stores[i],
        child: MonumentItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 10,
      ),
    );
  }
}
