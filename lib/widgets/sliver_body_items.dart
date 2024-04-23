import 'package:flutter/material.dart';
import 'package:synchronized_tabs/models/models.dart';

class SliverBodyItems extends StatelessWidget {

  final List<Product> listItem;

  const SliverBodyItems({
    super.key,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = listItem[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                product.description,
                                maxLines: 4,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                product.price,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              product.image,
                            ),
                          ),
                        ),
                        height: 140.0,
                        width: 130.0,
                      )
                    ],
                  ),
                ),
                if (index == listItem.length - 1) ... [
                  const SizedBox(height: 32.0),
                  Container(
                    height: 0.5,
                    color: Colors.white.withOpacity(0.3),
                  )
                ],
              ],
            ),
          );
        },
        childCount: listItem.length,
      ),
    );
  }
}
