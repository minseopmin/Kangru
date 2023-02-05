import 'package:flutter/material.dart';

class AppBarKangru extends StatelessWidget implements PreferredSizeWidget {
  const AppBarKangru({
    Key? key,
    required this.address,
    required this.appBar,
  }) : super(key: key);

  final String address;
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leadingWidth: 120,
      //TODO:leading width = the length of the text
      leading: Builder(
        builder: (context) => TextButton.icon(
          onPressed: () {
            Scaffold.of(context).openDrawer(); //TODO:Address filter setting
          },
          icon: const Icon(
            Icons.filter_alt,
            color: Colors.white,
          ),
          label: Text(
            address, //text of the Address
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
              fontSize: 20,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            null;
            //TODO:Search Widget setting
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            null;
            //TODO:Map function setting
          },
          icon: const Icon(
            Icons.map,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

Drawer DrawerKangru() {
  return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
    const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      child: Text(
        'Filter',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'SourceSansPro',
          fontSize: 20,
        ),
      ),
    ),
    ListTile(
        leading: Icon(
          Icons.food_bank,
          color: Colors.grey[850],
        ),
        title: const Text('Food'),
        onTap: () {
          null;
        },
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey)),
    ListTile(
        leading: Icon(
          Icons.location_on_outlined,
          color: Colors.grey[850],
        ),
        title: const Text('location'),
        onTap: () {
          null;
        },
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey)),
  ]));
}
