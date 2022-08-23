import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/text.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: text(index + 1),
        ),
        title: const text('Item title'),
        subtitle: const text('An apple mobile which is nothing like apple'),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              title: text('Edit'),
            ),
          );
        },
      ),
      itemCount: 12,
      shrinkWrap: true,
    );
  }
}
