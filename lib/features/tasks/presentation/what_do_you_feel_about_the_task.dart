import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flutter/material.dart';

class WhatDoYouFeelAboutTheTask extends StatelessWidget {
  const WhatDoYouFeelAboutTheTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) {
              return const _ModalBody();
            },
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, WorkOnTaskPage.pathName);
          },
          icon: const Icon(Icons.thumb_down),
        ),
      ],
    );
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({Key? key}) : super(key: key);

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
