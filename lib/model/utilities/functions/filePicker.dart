// /*
//
//
//
// import 'package:ecommerce/model/imports/generalImport.dart';
//
// class FilePickerClass{
//   // add image picking logic
//   // image file variable
//   FilePickerResult? result;
//   PlatformFile? file;
//   Future<String?> pickImage(context) async{
//     result = await FilePicker.platform.pickFiles(type: FileType.any);
//     if (result == null) return '';
//     file = result!.files.first;
//     // check image size to ensure it is not more than 5 mb
//     var kb;
//     file==null?Container():
//     kb=file!.size / 1024;
//     final mb = kb / 1024;
//     var size = (mb >= 1)
//         ? '${mb.toStringAsFixed(2)} MB'
//         : '${kb.toStringAsFixed(2)} KB';
//     var snackBar=SnackBar(content: GeneralTextDisplay('file size is greater than 5 mb, select another',
//         Color.fromRGBO(6, 18, 63, 1.0), 2, 14, FontWeight.w400, 'network connection'),
//       backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),elevation: 2.0,padding: EdgeInsets.only(left:35.0),
//     );
//
//     print(' i am size $size');
//     mb>5?ScaffoldMessenger.of(context).showSnackBar(snackBar):null;
//     return file!.path;
//   }
// }*/
//