import 'package:anka/feature/home/view/home_view.dart';
import 'package:anka/feature/login/view/login_view.dart';
import 'package:anka/feature/note/view/note_view.dart';
import 'package:anka/feature/pdf/view/pdf_view.dart';
import 'package:anka/feature/question/view/question_view.dart';
import 'package:anka/feature/signup/view/signup_view.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: AppRouter._replaceInRouteName)

/// Project router information
final class AppRouter extends RootStackRouter {
  static const _replaceInRouteName = 'View,Route';
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: QuestionRoute.page),
        AutoRoute(page: NoteRoute.page),
        AutoRoute(page: PdfRoute.page),
      ];
}
