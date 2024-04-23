import 'package:flutter/material.dart';
import 'package:synchronized_tabs/controller/controller.dart';
import 'package:synchronized_tabs/widgets/background_sliver.dart';
import 'package:synchronized_tabs/widgets/list_item_header_sliver.dart';
import 'package:synchronized_tabs/widgets/my_header_title.dart';
import 'package:synchronized_tabs/widgets/sliver_body_items.dart';
import 'package:synchronized_tabs/widgets/sliver_header_data.dart';

class HomeSliverWithTab extends StatefulWidget {
  const HomeSliverWithTab({super.key});

  @override
  State<HomeSliverWithTab> createState() => _HomeSliverWithTabState();
}

class _HomeSliverWithTabState extends State<HomeSliverWithTab> {

  final bloc = SliverScrollController();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Scrollbar(
        radius: const Radius.circular(8),
        notificationPredicate: (scroll) {
          bloc.valueScroll.value = scroll.metrics.extentInside;
          return true;
        },
        child: ValueListenableBuilder(
          valueListenable: bloc.globalOffsetValue,
          builder: (_, double valueCurrentScroll, __) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: bloc.scrollControllerGlobally,
              slivers: [
                _FlexibleSpaceBarHeader(
                  bloc: bloc,
                  valueScroll: valueCurrentScroll,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _HeaderSliver(bloc),
                ),
                for (var i = 0; i < bloc.listCategory.length; i++) ... [
                  SliverPersistentHeader(
                    delegate: MyHeaderTitle(
                      title: bloc.listCategory[i].category,
                      onHeaderChange: (visible) => bloc.refreshHeader(
                        i,
                        visible,
                        lastIndex: i > 0 ? i -1 : null,
                      ),
                    ),
                  ),
                  SliverBodyItems(listItem: bloc.listCategory[i].products)
                ]
              ],
            );
          }
        ),
      ),
    );
  }
}

class _FlexibleSpaceBarHeader extends StatelessWidget {

  final double valueScroll;
  final SliverScrollController bloc;

  const _FlexibleSpaceBarHeader({
    super.key,
    required this.valueScroll,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      stretch: true,
      expandedHeight: 250,
      pinned: valueScroll < 90 ? true : false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            const BackgroundSliver(),
            Positioned(
              right: 10,
              top: (sizeHeight + 30) - (bloc.valueScroll.value),
              child: const Icon(
                Icons.favorite,
                size: 30,
              ),
            ),
            Positioned(
              left: 10,
              top: (sizeHeight + 30) - bloc.valueScroll.value,
              child: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _maxHeaderExtend = 100.0;

class _HeaderSliver extends SliverPersistentHeaderDelegate {

  final SliverScrollController bloc;

  _HeaderSliver(this.bloc);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtend;
    if (percent > 0.1) {
      bloc.visibleHeader.value = true;
    } else {
      bloc.visibleHeader.value = false;
    }
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: _maxHeaderExtend,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      AnimatedOpacity(
                        opacity: percent > 0.1 ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(Icons.arrow_back),
                      ),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: Offset(percent < 0.1 ? -0.18 : 0.1, 0),
                        curve: Curves.easeIn,
                        child: const Text(
                          'Kavsoft Bakery',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: percent > 0.1
                        ? ListItemHeaderSliver(bloc: bloc)
                        : const SliverHeaderData(),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (percent > 0.1) ... [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: percent > 0.1
                  ? Container(
                      height: 0.5,
                      color: Colors.white,
                  )
                  : null,
            ),
          ),
        ]
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtend;

  @override
  double get minExtent => _maxHeaderExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}
