import 'package:flutter/material.dart';

class BaseTaskTabPage extends StatefulWidget {
  const BaseTaskTabPage({Key? key}) : super(key: key);

  @override
  State<BaseTaskTabPage> createState() => _BaseTaskTabPageState();
}

class _BaseTaskTabPageState extends State<BaseTaskTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Task tab'),
    );
  }
}
