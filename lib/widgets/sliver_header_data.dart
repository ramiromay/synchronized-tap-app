import 'package:flutter/material.dart';

class SliverHeaderData extends StatelessWidget {
  const SliverHeaderData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Asiatisch . Koreanisch . Japnisch',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
              ),
              SizedBox(width: 4.0),
              Text(
                '30-40 min    4.3',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(width: 6.0),
              Icon(
                Icons.star,
                size: 14,
              ),
              SizedBox(width: 8.0),
              Text(
                '\$6.50 Fee',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
