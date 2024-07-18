import 'package:fasionxt/views/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color _backgroundColor = Colors.blue;
  String _avatarPath = 'assets/images/avatar_1.jpg';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _backgroundColor =
          Color(_prefs.getInt('backgroundColor') ?? Colors.blue.value);
      _avatarPath =
          _prefs.getString('avatarPath') ?? 'assets/images/avatar_1.jpg';
    });
  }

  void _changeBackgroundColor() async {
    Color selectedColor = _backgroundColor;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Warna Background'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              selectedColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _backgroundColor = selectedColor;
              });
              _prefs.setInt('backgroundColor', _backgroundColor.value);
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _changeAvatar() async {
    String selectedAvatar = _avatarPath;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Avatar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Image.asset('assets/images/avatar_1.jpg',
                  width: 50, height: 50),
              title: Text('Avatar 1'),
              onTap: () {
                selectedAvatar = 'assets/images/avatar_1.jpg';
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/avatar_2.jpg',
                  width: 50, height: 50),
              title: Text('Avatar 2'),
              onTap: () {
                selectedAvatar = 'assets/images/avatar_2.jpg';
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/avatar_3.jpg',
                  width: 50, height: 50),
              title: Text('Avatar 3'),
              onTap: () {
                selectedAvatar = 'assets/images/avatar_3.jpg';
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
    setState(() {
      _avatarPath = selectedAvatar;
    });
    _prefs.setString('avatarPath', _avatarPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  color: _backgroundColor,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: _changeBackgroundColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 175,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(_avatarPath),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.black),
                                onPressed: _changeAvatar,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildShortcutMenu(Icons.all_inbox, 'Dikemas'),
                      _buildShortcutMenu(Icons.history, 'History'),
                      _buildShortcutMenu(Icons.payment, 'Pembayaran'),
                      _buildShortcutMenu(Icons.star, 'Penilaian'),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildProfileMenu(Icons.list_alt, 'Pesanan Saya'),
                  _buildProfileMenu(Icons.favorite, 'Favorit Saya'),
                  _buildProfileMenu(Icons.settings, 'Pengaturan Akun'),
                  _buildProfileMenu(Icons.help, 'Pusat Bantuan'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: purplePrimary,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Log out action
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Terms and Conditions action
              },
              child: Text(
                'Terms and Conditions',
                style: TextStyle(
                  color: bluePrimary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              'Version 0.1',
              style: TextStyle(
                color: greyPrimary,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutMenu(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildProfileMenu(IconData icon, String label) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(label),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
      ],
    );
  }
}
