import 'package:fasionxt/models/pengguna.dart';
import 'package:fasionxt/services/apis/profile.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  final Pengguna pengguna;

  AccountSettingsPage({required this.pengguna});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Akun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengaturan Akun',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildSettingItem(
                context,
                'Ubah Nama Lengkap',
                Icons.card_membership,
                NamePopup(
                  name: widget.pengguna.nama,
                )),
            _buildSettingItem(
                context,
                'Ubah Username',
                Icons.person,
                UsernamePopup(
                  username: widget.pengguna.username,
                )),
            _buildSettingItem(
                context, 'Ubah Password', Icons.lock, PasswordPopup()),
            _buildSettingItem(
                context,
                'Ubah Alamat',
                Icons.home,
                AddressPopup(
                  address: widget.pengguna.alamat,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, String title, IconData icon, Widget popup) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return popup;
            },
          );
        },
      ),
    );
  }
}

class NamePopup extends StatelessWidget {
  final String name;
  final TextEditingController _nameController;

  NamePopup({
    required this.name,
  }) : _nameController = TextEditingController(text: name);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Nama',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text;
                    var result =
                        await APIProfileService().pengaturanAkun(nama: name);
                    Navigator.of(context).pop();
                    if (result['success'] != null) {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['success']);
                    } else {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['error']);
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purplePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UsernamePopup extends StatelessWidget {
  final String username;
  final TextEditingController _usernameController;

  UsernamePopup({
    required this.username,
  }) : _usernameController = TextEditingController(text: username);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Username',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username Baru',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    var result = await APIProfileService()
                        .pengaturanAkun(username: username);
                    Navigator.of(context).pop();
                    if (result['success'] != null) {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['success']);
                    } else {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['error']);
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purplePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordPopup extends StatelessWidget {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Password Lama',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'Password Baru',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    String passwordLama = _currentPasswordController.text;
                    String passwordBaru = _newPasswordController.text;
                    var result = await APIProfileService().pengaturanAkun(
                        passwordLama: passwordLama, passwordBaru: passwordBaru);
                    Navigator.of(context).pop();
                    if (result['success'] != null) {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['success']);
                    } else {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['error']);
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purplePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddressPopup extends StatelessWidget {
  final String address;
  final TextEditingController _addressController;

  AddressPopup({
    required this.address,
  }) : _addressController = TextEditingController(text: address);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Alamat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Alamat Baru',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    String alamat = _addressController.text;
                    var result = await APIProfileService()
                        .pengaturanAkun(alamat: alamat);
                    Navigator.of(context).pop();
                    if (result['success'] != null) {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['success']);
                    } else {
                      SnackbarUtils.showSuccessSnackbar(
                          context, result['error']);
                    }
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purplePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
