import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? _storedImage;

  Future<void> _takePicture () async{
    final _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: ImageSource.camera,
    maxHeight: 600,
    );
    setState(() {
      //_storedImage = File((image as XFile).path);
       _storedImage = File(imageFile!.path);
    });
    final appDir = await syspaths.getApplicationSupportDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await (File(imageFile.path)).copy('${appDir.path}/$fileName');
    print("saved iMage");
    print(imageFile.name);
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        Container(
         width: 150,
         height: 100,
         decoration: BoxDecoration(
           border: Border.all(
             width: 1,
             color: Colors.grey,
           ),
         ),
          child:  _storedImage != null
              ? Image.file(_storedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          ) : Text('No Image Found',textAlign: TextAlign.center,),
        alignment: Alignment.center,    
    ),
        SizedBox(width: 10,),
      Expanded(
        child:TextButton.icon(onPressed: _takePicture,
             icon:  Icon(Icons.camera),
             label: Text('Take Picture'),
        ),
      ),
      ],
    );
  }
}
