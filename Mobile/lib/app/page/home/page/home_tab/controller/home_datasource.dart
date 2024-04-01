import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/category_model.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/mock_home_hot_task_slider_model.dart';
import 'package:plat_app/app/page/home/page/home_tab/widgets/widgets.dart';

import '../models/mock_user_model.dart';

final MockUserModel mockLoginUser = MockUserModel(
  name: 'John Doe',
  avatar:
      'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  language: 'English',
  notification: 3,
);

final List<Category> mockHomeCategories = [
  Category(name: 'all_tasks'.tr, isComingSoon: false),
  Category(name: 'check_in'.tr),
  Category(name: 'video'.tr),
  Category(name: 'install_app'.tr),
];

final List<MockHomeHotTaskSliderModel> mockHomeHotTaskSliders = [
  MockHomeHotTaskSliderModel(
    id: '1',
    title: 'Get 10% off on your first order',
    imageUrl:
        'https://img.freepik.com/free-vector/flat-sale-illustration_23-2148990766.jpg?w=2000',
    url: 'https://www.google.com',
  ),
  MockHomeHotTaskSliderModel(
    id: '2',
    title: 'Get 10% off on your first order',
    imageUrl: 'https://mivietnam.vn/wp-content/uploads/2021/04/orange.jpg',
    url: 'https://www.google.com',
  ),
  MockHomeHotTaskSliderModel(
    id: '3',
    title: 'Get 10% off on your first order',
    imageUrl:
        'https://www.omotesandohills.com/sp/sale/2022winter/images/sale.jpg',
    url: 'https://www.google.com',
  ),
];
