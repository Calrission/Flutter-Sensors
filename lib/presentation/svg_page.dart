import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensor_project/domain/svg_use_case.dart';

class SvgPage extends StatefulWidget {
  const SvgPage({super.key});

  @override
  State<SvgPage> createState() => _SvgPageState();
}

class _SvgPageState extends State<SvgPage> {

  Uint8List? image;
  SvgUseCase useCase = SvgUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (image == null)
              ? SvgPicture.asset(
                  "assets/placeholder.svg",
                  width: 220,
                  height: 220
                )
              : SvgPicture.memory(image!,
                  width: 220,
                  height: 220
                ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () async {
                image = await useCase.pressPickSVG();
                setState(() {});
              },
              child: const Text("Выбрать SVG")
            )
          ],
        ),
      ),
    );
  }
}