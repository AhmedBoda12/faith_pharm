import 'package:faith_pharm/constants.dart';
import 'package:faith_pharm/helper/api.dart';
import 'package:faith_pharm/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductServices {
  Future<List<ProductModel>> getAllProducts() async {
    String? token = await getToken();

    var data = await Api().get(
      url: '$baseUrl/product/',
      token: token,
    );
    List<ProductModel> productList = [];
    for (int i = 0; i < data.length; i++) {
      productList.add(ProductModel.fromJson(data[i]));
    }
    return productList;
  }

  Future<ProductModel> getProductById(String id) async {
    String? token = await getToken();

    var data = await Api().get(
      url: '$baseUrl/product/find/$id',
      token: token,
    );
    return ProductModel.fromJson(data);
  }

  Future<List<ProductModel>> getProductsByCategory(String id) async {
    String? token = await getToken();
    var data = await Api().get(
      url: '$baseUrl/product/find/$id',
      token: token,
    );
    List<ProductModel> productList = [];
    for (int i = 0; i < data.length; i++) {
      productList.add(ProductModel.fromJson(data[i]));
    }
    return productList;
  }

  Future<dynamic> deleteProduct({required String productId}) async {
    String? token = await getToken();

    var data = await Api().delete(
      url: '$baseUrl/product/delete/$productId',
      token: token,
    );

    return data;
  }

  Future<ProductModel> addProduct(ProductModel productModel) async {
    String? token = await getToken();

    var data = await Api().post(
      url: '$baseUrl/product/create',
      body: productModel.toJson(),
      token: token,
    );

    return ProductModel.fromJson(data);
  }

  // Function to retrieve token from SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
