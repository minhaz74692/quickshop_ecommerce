import 'package:hive/hive.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';

class BookmarkService {
  final bookmarkedList = Hive.box(Constants.bookmarkTag);

  Future handleBookmarkIconPressed(ProductsModel product, context) async {
    if (bookmarkedList.keys.contains(product.id)) {
      removeFromBookmarkList(product);
    } else {
      addToBookmarkList(product);
      showMessage('added to your bookamrk');
    }
  }

  Future addToBookmarkList(ProductsModel product) async {
    await bookmarkedList.put(product.id, {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'image': product.image,
      'price': product.price,
    });
  }

  Future removeFromBookmarkList(ProductsModel product) async {
    await bookmarkedList.delete(product.id);
  }

  Future clearBookmarkList() async {
    await bookmarkedList.clear();
  }
}
