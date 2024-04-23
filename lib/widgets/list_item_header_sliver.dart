import 'package:flutter/material.dart';
import 'package:synchronized_tabs/controller/controller.dart';
import 'package:synchronized_tabs/models/models.dart';
import 'package:synchronized_tabs/widgets/get_box_offset.dart';

class ListItemHeaderSliver extends StatelessWidget {

  final SliverScrollController bloc;

  const ListItemHeaderSliver({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final itemOffSets = bloc.listOffSetItemHeader;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) => true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              right: size.width -
                  (itemOffSets[itemOffSets.length - 1] -
                      itemOffSets[itemOffSets.length - 2])),
          controller: bloc.scrollControllerItemHeader,
          // physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: ValueListenableBuilder(
            valueListenable: bloc.headerNotifier,
            builder: (_, MyHeader? snapshot , __) {
              return Row(
                children: List.generate(
                  bloc.listCategory.length,
                  (index) {
                    // Esta parte hace que no se muestre min 16
                    return GetBoxOffSet(
                      offset: (offset) => itemOffSets[index] = offset.dx,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          right: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: index == snapshot!.index ? Colors.white : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          bloc.listCategory[index].category,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: index == snapshot!.index ? Colors.black : Colors.white
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
