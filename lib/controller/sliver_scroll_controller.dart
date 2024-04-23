import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:synchronized_tabs/data/data.dart';
import 'package:synchronized_tabs/models/models.dart';

class SliverScrollController {

  // List of products
  late List<ProductCategory> listCategory;

  // List of offset values
  List<double> listOffSetItemHeader = [];

  // Header notifier
  final headerNotifier = ValueNotifier<MyHeader?>(null);

  // Global offset value
  final globalOffsetValue = ValueNotifier<double>(0);

  // Indicator if we are going down up in the application
  final goingDown = ValueNotifier<bool>(false);

  // Value to do the validations of the top icons
  final valueScroll = ValueNotifier<double>(0);

  // To move top items in sliver
  late ScrollController scrollControllerItemHeader;

  // To have overall control of scrolling
  late ScrollController scrollControllerGlobally;

  // Value that indicates if the header is visible
  final visibleHeader = ValueNotifier(false);

  void loadDataRandom() {
    final productsTwo = [...products];
    final productsThree = [... products];
    final productsFour = [... products];

    productsTwo.shuffle();
    productsThree.shuffle();
    productsFour.shuffle();

    listCategory = [
      ProductCategory(
        category: 'Order Again',
        products: products,
      ),
      ProductCategory(
        category: 'Picked For You',
        products: productsTwo,
      ),
      ProductCategory(
        category: 'Startes',
        products: productsThree,
      ),
      ProductCategory(
        category: 'Gimpub Sushi',
        products: productsFour,
      ),
    ];
  }

  void init() {
    loadDataRandom();
    listOffSetItemHeader = List.generate(listCategory.length, (index) => index.toDouble());
    scrollControllerGlobally = ScrollController();
    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobally.addListener(_listToScrollChange);
    headerNotifier.addListener(_listenHeaderNotifier);
    visibleHeader.addListener(_listenVisibleHeader);
  }

  void _listenVisibleHeader() {
    if (visibleHeader.value) {
      headerNotifier.value = const MyHeader(index: 0, visible: false);
    }
  }

  void _listenHeaderNotifier() {
    if (visibleHeader.value) {
      for (var i = 0; i < listCategory.length; i ++) {
        scrollAnimationHorizontal(index: i);
      }
    }
  }

  void scrollAnimationHorizontal({required int index}) {
    if (headerNotifier.value?.index == index && headerNotifier.value!.visible) {
      scrollControllerItemHeader.animateTo(
        listOffSetItemHeader[headerNotifier.value!.index] - 16,
        duration: const Duration(milliseconds: 250),
        curve: goingDown.value ? Curves.bounceInOut : Curves.fastOutSlowIn,
      );
    }
  }

  void dispose() {
    scrollControllerItemHeader.dispose();
    scrollControllerGlobally.dispose();
  }

  void _listToScrollChange() {
    globalOffsetValue.value = scrollControllerGlobally.offset;
    if (scrollControllerGlobally.position.userScrollDirection == ScrollDirection.reverse) {
      goingDown.value = true;
    } else {
      goingDown.value = false;
    }
  }

  void refreshHeader(int index, bool visible, {int? lastIndex}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.index ?? index;
    final headerVisible = headerValue?.visible ?? false;

    if (headerTitle != index || lastIndex != null || headerVisible) {
      Future.microtask(() => {
        if (!visible && lastIndex != null) {
          headerNotifier.value = MyHeader(
            index: lastIndex,
            visible: true,
          )
        } else {
          headerNotifier.value = MyHeader(
            index: index,
            visible: true,
          ),
        }
      });
    }

  }

}