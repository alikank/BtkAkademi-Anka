import 'package:anka/product/navigation/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            accountName: Text(
              "E-posta",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            accountEmail: Text(
              "alikankosee1@gmail.com",
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/anka_profil.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "Ana Sayfa",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            onTap: () {
              context.router.push(const HomeRoute());
            },
          ),
          ListTile(
            leading: Icon(Icons.question_mark_outlined,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "Soru Çözdür",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            onTap: () {
              context.router.push(const QuestionRoute());
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "Not Çıkar",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            onTap: () {
              context.router.push(const NoteRoute());
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf_outlined,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "PDF Özetle",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            onTap: () {
              context.router.push(const PdfRoute());
            },
          ),
          ListTile(
            leading: Icon(Icons.person,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "Profil",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.onSurface),
            title: Text(
              "Ayarlar",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
            title: Text(
              "Çıkış Yap",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.red),
            ),
            onTap: () {
              context.router.push(const LoginRoute());
            },
          ),
        ],
      ),
    );
  }
}
