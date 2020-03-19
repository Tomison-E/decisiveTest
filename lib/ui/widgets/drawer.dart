
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child:ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          Divider(),
          _createDrawerItem(icon: Icons.home,text: 'Profile',),
          _createDrawerItem(icon: Icons.dashboard, text: 'Dashboard',),
          _createDrawerItem(icon: Icons.date_range, text: 'Reservations',),
          _createDrawerItem(icon: Icons.description, text: 'Reports',),
          _createDrawerItem(icon: Icons.create_new_folder, text: 'Create Deals'),
          Divider(),
          _createDrawerItem(icon: Icons.settings, text: 'Settings'),
          _createDrawerItem(icon: Icons.exit_to_app, text: 'Log Out'),
        ],
      ),color: Colors.blue,
      )
    );
  }


  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Colors.blue),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 15.0,
              left: 25.0,
              child: RichText(text: TextSpan(text: "             decisive\n\n",style: TextStyle(color: Colors.white,fontSize: 20.0),
              children: [
                TextSpan(text: "The George\n",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0),),
                TextSpan(text: "Ikoyi",style: TextStyle(color: Colors.indigo,fontSize: 15))
              ]),)),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(text,style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      onTap: onTap,
    );
  }



}