import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class AvatarUseCase {

  XFile? avatar;
  final Future<ImageSource?> Function() onChooseSource;
  final Function(Uint8List) onPickAvatar;
  final Function() onRemoveAvatar;

  AvatarUseCase(
    {
      required this.onChooseSource,
      required this.onPickAvatar,
      required this.onRemoveAvatar
    }
  );


  void pressButton(){
    if (avatar != null){
      pressRemoveButton();
    }else{
      pressChangeButton();
    }
  }

  Future<void> pressChangeButton() async {
    var imageSource = await onChooseSource();
    if (imageSource == null){
      return;
    }
    avatar = await ImagePicker().pickImage(source: imageSource);
    var bytes = await avatar?.readAsBytes();
    if (bytes != null) {
      onPickAvatar(bytes);
    }
  }

  void pressRemoveButton(){
    avatar = null;
    onRemoveAvatar();
  }
}