import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/widgets/drawer.dart';
import 'package:ui_gp/widgets/monument/monuments_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class MonumentsMenu extends StatefulWidget {
  @override
  _MonumentsMenuState createState() => _MonumentsMenuState();
}

class _MonumentsMenuState extends State<MonumentsMenu> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = true;
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Monuments>(context).fetchAndSetMonuments().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          ///search bar by using textfields
          ///3ayzen nshlhaaaaz
          title: !isSearch
              ? Text('Available Monuments ')
              : TextField(
                  decoration:
                      InputDecoration(hintText: 'Search For Monuments Here'),
                ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.all,
                ),
              ],
            ),
            isSearch
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        isSearch = false;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        isSearch = true;
                      });

                      //search here
                    })
          ]),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MonumentsGrid(_showOnlyFavorites),
    );
  }
}
