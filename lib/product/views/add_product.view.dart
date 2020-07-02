import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:todo_app_getx/product/product.controller.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ProductController productController = Get.put(ProductController());

  List<Asset> images = List<Asset>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
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

    setState(() {
      resultList.addAll(images);
      images = resultList;
    });
  }
}
