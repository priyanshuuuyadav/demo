import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:untitled1/controllers/razorpay_api.dart';
import '../models/items_model.dart';

class ItemsProvider extends GetxController with StateMixin {
  RxList<Item> items = RxList();

  @override
  onInit() {
    super.onInit();
    items.clear();
    getItems();
  }

  getItems() async {
    var a = await RazorpayAPI.getItems();
    items = a.obs;
  }

  createItem(Item item) async {
    items.add(item);
    RazorpayAPI.createItem(item);
  }

  removeItem(String id) async {
    items.removeWhere((element) => element.id == id);
    RazorpayAPI.deleteItem(id);
  }

  updateItem(Item item) async {
    final index = items.indexWhere((amount) => amount.id == item.id);
    items[index] = item;
    RazorpayAPI.updateItem(item);
  }
}
