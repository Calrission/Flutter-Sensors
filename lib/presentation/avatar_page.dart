import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sensor_project/domain/avatar_use_case.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {

  Uint8List? avatar;

  late AvatarUseCase useCase;

  void onPickAvatar(Uint8List bytes){
    setState(() {
      avatar = bytes;
    });
  }

  void onRemoveAvatar(){
    setState(() {
      avatar = null;
    });
  }

  Future<ImageSource?> onChooseSource() async {

    ImageSource? imageSource;

    await showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text("Выберите источник"),
      actions: [
        TextButton(onPressed: (){
          imageSource = ImageSource.camera;
          Navigator.pop(context);
        }, child: const Text("Камера")),
        TextButton(onPressed: (){
          imageSource = ImageSource.gallery;
          Navigator.pop(context);
        }, child: const Text("Галлерея"))
      ],
    ));

    return imageSource;
  }

  @override
  void initState() {
    super.initState();
    useCase = AvatarUseCase(
      onChooseSource: onChooseSource,
      onPickAvatar: onPickAvatar,
      onRemoveAvatar: onRemoveAvatar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: (avatar == null)
                ? Container(width: 180, height: 180, color: Colors.grey)
                : Image.memory(avatar!, width: 180, height: 180, fit: BoxFit.cover),
            ),
            const SizedBox(height: 38),
            FilledButton(
              onPressed: useCase.pressButton,
              child: Text((avatar != null) ? "Удалить" : "Добавить")
            )
          ],
        ),
      ),
    );
  }
}