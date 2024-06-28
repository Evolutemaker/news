import 'package:auto_route/auto_route.dart';
import 'package:news/src/presentation/screens/news_screen/news_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewsRoute.page, initial: true),
      ];
}