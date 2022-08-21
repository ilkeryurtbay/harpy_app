import 'package:flutter/material.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key, required String title});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
            ),
            title: const Text("Bildirimler"),
            textColor: Colors.white,
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              Icons.security,
              color: Colors.white,
            ),
            title: const Text("Güvenlik"),
            textColor: Colors.white,
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              Icons.flag_outlined,
              color: Colors.white,
            ),
            title: const Text("Reklamlar"),
            textColor: Colors.white,
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              Icons.account_box,
              color: Colors.white,
            ),
            title: const Text("Hesap"),
            textColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, "account"),
          ),
          ListTile(
            leading: const Icon(
              Icons.help_outline_outlined,
              color: Colors.white,
            ),
            title: const Text("Yardım"),
            textColor: Colors.white,
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            title: const Text("Hakkında"),
            textColor: Colors.white,
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              Icons.color_lens_outlined,
              color: Colors.white,
            ),
            title: const Text("Tema"),
            textColor: Colors.white,
            onTap: () => false,
          ),
        ],
      ),
    );
  }
}
