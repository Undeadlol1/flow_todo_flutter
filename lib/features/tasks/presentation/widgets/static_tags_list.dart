import 'package:flutter/material.dart';

class StaticTagsList extends StatelessWidget {
  const StaticTagsList({Key? key, required List<String> tags})
      : _tags = tags,
        super(key: key);

  final List<String> _tags;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _tags.isNotEmpty
          ? Wrap(
              children: _tags
                  .map(
                    (tag) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Chip(
                        label: Text(tag),
                      ),
                    ),
                  )
                  .toList(),
            )
          : const SizedBox(),
    );
  }
}
