import 'package:flutter/material.dart';

class BaseHomeTabPage extends StatefulWidget {
  const BaseHomeTabPage({Key? key}) : super(key: key);

  @override
  State<BaseHomeTabPage> createState() => _BaseHomeTabPageState();
}

class _BaseHomeTabPageState extends State<BaseHomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Home tab'),
    );
  }
}
