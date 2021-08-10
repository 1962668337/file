import 'package:get/get.dart';
import '../../page_content.dart';
part 'app_routes.dart';

class AppPages {
  static const Intial = AppRoutes.photo;

  static final routes = [
    GetPage(name: AppRoutes.photo, page: () => PageContent('/photo')),
    GetPage(name: AppRoutes.video, page: () => PageContent('/video')),
    GetPage(name: AppRoutes.text, page: () => PageContent('/text')),
    GetPage(
        name: AppRoutes.PictureJumpPage,
        page: () => PageContent('/PictureJumpPage')),
    GetPage(
        name: AppRoutes.PictureThreeLevelPage,
        page: () => PageContent('/PictureThreeLevelPage')),
    GetPage(
        name: AppRoutes.VideoPlaybackHomepage,
        page: () => PageContent('/VideoPlaybackHomepage')),
  ];
}
