import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fiveg/common_widgets/avatar.dart';
import 'package:fiveg/common_widgets/platform_alert_dialog.dart';
import 'package:fiveg/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _serverAddress = '';
  SharedPreferences prefs;
  TextEditingController _controller;

  initState() {
    super.initState();

    _initData();
    //_initItems();
  }

  _initData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _serverAddress = prefs.getString('server') ?? 'demo.cloudwebrtc.com';
    });
    _controller = new TextEditingController(text: _serverAddress);
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout??',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _confirmSignOut(context),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: _buildUserInfo(user),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            TextField(
              textAlign: TextAlign.center,
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: 'Type in IP Address'),
            ),
            SizedBox(height: 8,),
            RaisedButton(
              onPressed: () {
                // You can also use the controller to manipuate what is shown in the
                // text field. For example, the clear() method removes all the text
                // from the text field.
                // _controller.clear();
                prefs.setString('server', _controller.text);
              },
              child: new Text('SAVE'),
            ),
          ],
        ));
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: "https://images.unsplash.com/photo-1570343096246-092fa979a4b8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80",
          radius: 50,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(height: 8),
      ],
    );
  }
}
