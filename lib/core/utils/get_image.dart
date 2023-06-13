import 'package:flutter/services.dart';

Future<String?> getImgUrl(String imageUrl) async {
//Storage structre: avatars/+919999999999/avatar.jpg
//Permanent url of an image without tokens
//%2F means "/"
//%2B mans "+"

  try {
    (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
        .buffer
        .asUint8List();
    print("The image exists!");
    return imageUrl;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
