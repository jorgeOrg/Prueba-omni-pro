import 'package:flutter/material.dart';

import '../../core/entities/user.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.data,
  }) : super(key: key);

  final User? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const  EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(data!.thumbnailUrl)
              ),
              const SizedBox(height: 10,),
              Text(data!.title.toUpperCase())
            ],
          ),
        ),
      ),
    );
  }
}