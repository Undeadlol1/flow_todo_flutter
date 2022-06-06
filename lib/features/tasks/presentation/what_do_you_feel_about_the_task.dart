import 'package:flutter/material.dart';

class WhatDoYouFeelAboutTheTask extends StatelessWidget {
  const WhatDoYouFeelAboutTheTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () => _showBottomSheet(context),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_down)),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const _ModalBody();
        });
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.favorite),
          title: _buildText('Made step forward'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.emoji_emotions),
          title: _buildText('Advanced a lot'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.check),
          title: _buildText('Done'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }
}
