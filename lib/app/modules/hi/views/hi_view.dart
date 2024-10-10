import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hi_controller.dart';

class HiView extends GetView<HiController> {
  const HiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
