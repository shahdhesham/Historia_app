import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_gp/providers/monuments.dart';
import 'package:ui_gp/screens/crudmonument.dart';
import 'package:ui_gp/widgets/admin_monument.dart';
import 'package:ui_gp/widgets/drawer.dart';

class AdminPage extends StatelessWidget {
  static const routeName = '/user-monuments';

  Future<void> _refreshMonuments(BuildContext context) async {
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
          future: _refreshMonuments(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshMonuments(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<Monuments>(
                        builder: (context, monumentsData, child) =>
                            ListView.builder(
                          itemCount: monumentsData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              AdminMonument(
                                monumentsData.items[i].id,
                                monumentsData.items[i].monumentName,
                                monumentsData.items[i].imageUrl,
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
