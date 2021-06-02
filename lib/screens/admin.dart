import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/screens/crudmonument.dart';
import 'package:ui_gp/widgets/admin_monument.dart';
import 'package:ui_gp/widgets/drawer.dart';

class AdminPage extends StatelessWidget {
  static const routeName = '/user-stores';

  Future<void> _refreshStores(BuildContext context) async {
    await Provider.of<Monuments>(context, listen: false).fetchAndSetMonuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Monuments'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.of(context).pushNamed(EditStore.routeName);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => crudMonument()),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<Object>(
          future: _refreshStores(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshStores(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<Monuments>(
                        builder: (context, storesData, child) =>
                            ListView.builder(
                          itemCount: storesData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              
                              AdminMonument(
                                storesData.items[i].id,
                                storesData.items[i].monumentName,
                                storesData.items[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
