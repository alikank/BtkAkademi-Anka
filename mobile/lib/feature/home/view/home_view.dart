import 'package:anka/product/navigation/app_router.dart';
import 'package:anka/product/widgets/appbar/appbar.dart';
import 'package:anka/product/widgets/cardWidget/home_card.dart';
import 'package:anka/product/widgets/drawer/drawer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        autoLeading: true,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HomeCardWidget(
              leadingIcon: Icons.question_mark_outlined,
              title: 'Soru Çözdür',
              subtitle: 'Yapay zeka ile sorularınızı çözdürebilirsiniz.',
              onPressed: () {
                context.router.push(const QuestionRoute());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HomeCardWidget(
              leadingIcon: Icons.note_alt_outlined,
              title: 'Not Çıkar',
              subtitle:
                  'Yapay zeka ile başlık veya kod vererek not çıkarabilirsiniz',
              onPressed: () {
                context.router.push(const NoteRoute());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HomeCardWidget(
              leadingIcon: Icons.picture_as_pdf_outlined,
              title: 'PDF Özetle',
              subtitle:
                  'Yapay zeka ile PDF dosyalarınızı özetlettirebilirsiniz.',
              onPressed: () {
                context.router.push(const PdfRoute());
              },
            ),
          )
        ],
      ),
    );
  }
}
