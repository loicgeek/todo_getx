import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:todo_app_getx/auth/auth.controller.dart';
import 'package:todo_app_getx/product/models/image.model.dart';
import 'package:todo_app_getx/product/product.controller.dart';
import 'package:todo_app_getx/product/product.service.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ProductController productController = ProductController.to;

  List<Asset> images = List<Asset>();
  List<ImageModel> remoteImages = List<ImageModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveProduct();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: productController.productName,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextFormField(
              controller: productController.productPrice,
              decoration: InputDecoration(hintText: "Price"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: productController.productQty,
              decoration: InputDecoration(hintText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: productController.productDesc,
              minLines: 3,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Description",
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildGridView(),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadAssets();
        },
        child: Icon(
          Icons.camera_alt,
        ),
      ),
    );
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: <Widget>[
                AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                    child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.black.withOpacity(.5),
                  child: Center(
                    child: GestureDetector(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            images = images
                                .where((element) =>
                                    element.identifier != asset.identifier)
                                .toList();
                          });
                        }),
                  ),
                ))
              ],
            ),
          );
        }),
      );
    else
      return Container(
        child: Center(
          child: Icon(
            Icons.image,
            size: 50,
            color: Colors.black,
          ),
        ),
      );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (resultList != null) {
      setState(() {
        resultList.addAll(images);
        images = resultList;
      });
    }
  }

  void saveProduct() {
    var user = AuthController.to.user.value;
    ProductService productService = new ProductService();
    Get.rawSnackbar(
      title: "Saving",
      messageText: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
    productService
        .addOne(
      userId: user.uid,
      name: productController.productName.text,
      price: double.parse(productController.productPrice.text),
      quantity: int.parse(productController.productQty.text),
      desc: productController.productDesc.text,
      username: user.displayName,
    )
        .then((product) async {
      for (var i = 0; i < images.length; i++) {
        var img = await saveImage(images[i]);
        remoteImages.add(img);
      }
      productService.addGallery(product.id, remoteImages);
      setState(() {
        remoteImages = [];
        images = [];
        productController.productName.clear();
        productController.productPrice.clear();
        productController.productQty.clear();
        productController.productDesc.clear();
      });
      Get.snackbar("Success", "Product saved");
    });
  }
}

Future<ImageModel> saveImage(Asset asset) async {
  ByteData byteData = await asset.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();
  var now = DateTime.now().millisecondsSinceEpoch;
  StorageReference ref = FirebaseStorage.instance.ref().child("$now.jpg");
  StorageUploadTask uploadTask = ref.putData(imageData);
  final StreamSubscription<StorageTaskEvent> streamSubscription =
      uploadTask.events.listen((event) {
    // You can use this to notify yourself or your user in any kind of way.
    // For example: you could use the uploadTask.events stream in a StreamBuilder instead
    // to show your user what the current status is. In that case, you would not need to cancel any
    // subscription as StreamBuilder handles this automatically.

    // Here, every StorageTaskEvent concerning the upload is printed to the logs.
    print(
        "${(event.snapshot.bytesTransferred * 100 / event.snapshot.totalByteCount)}%");
    print('EVENT ${event.type}');
  });
  var storageSnapshot = await uploadTask.onComplete;
// Cancel your subscription when done.
  streamSubscription.cancel();
  var url = await storageSnapshot.ref.getDownloadURL();
  return ImageModel(id: "$now", url: url);
}
