import 'package:flutter/material.dart';
import 'package:love_flutter_app/generated/l10n.dart';

class LeftSideDrawer extends StatelessWidget {
  const LeftSideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Row(
              children: [
                Text(S.of(context).projectManagement),
                Icon(Icons.calendar_today)
              ],
            ),
            children: <Widget>[
              ListTile(
                title: Text("Timesheets"),
              ),
              ListTile(
                title: Text("Out of Office"),
              ),
              ListTile(
                title: Text("Projects"),
              ),
              ListTile(title: Text("Invoices")),
            ],
          ),
          ExpansionTile(
            title: Row(
              children: [
                Text(S.of(context).documents),
                Icon(Icons.plagiarism_outlined)
              ],
            ),
            children: <Widget>[
              ListTile(
                title: Text("Retrieve"),
              ),
              ListTile(
                title: Text("Reissue"),
              ),
              ListTile(
                title: Text("Reports"),
              ),
            ],
          ),
          ExpansionTile(
            title: Row(
              children: [
                Text(S.of(context).orders),
                Icon(Icons.production_quantity_limits_rounded)
              ],
            ),
            children: <Widget>[
              ListTile(
                title: Text("New"),
              ),
              ListTile(
                title: Text("Processed"),
              ),
              ListTile(title: Text("Shipped")),
              ListTile(
                title: Text('Returned'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RightSideDrawer extends StatelessWidget {
  const RightSideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(S.of(context).profile),
          )
        ],
      ),
    );
  }
}
