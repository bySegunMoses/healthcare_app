import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_healthcare_app/src/model/cart.dart';
import 'package:flutter_healthcare_app/src/model/orderDetails.dart';
import 'package:flutter_healthcare_app/src/model/place_order.dart';

void main() {
  group('pharmacy order models', () {
    test('place order serializes its cart items', () {
      final placeOrder = PlaceOrder.fromJson({
        'userId': 'patient-5',
        'productList': [
          {
            'Id': 'cart-1',
            'Productid': 'medicine-9',
            'Productname': 'Pain relief',
            'Productqnty': '2',
          },
        ],
      });

      expect(placeOrder.userId, 'patient-5');
      expect(placeOrder.productList.single.productname, 'Pain relief');
      expect(placeOrderFromJson(placeOrderToJson(placeOrder))
          .productList.single.productqnty, '2');
    });

    test('order details parses nested purchased products', () {
      final details = orderDetailsFromJson(
        '{"orderId":"order-3","orderForUser":"patient-5",'
        '"orderStatus":"Confirmed","OrderList":['
        '{"Id":"line-1","Productid":"medicine-9",'
        '"MedicineName":"Pain relief","Productprice":"12.50",'
        '"Productqnty":"2"}]}',
      );

      expect(details.orderStatus, 'Confirmed');
      expect(details.orderList.single.medicineName, 'Pain relief');
      expect(orderDetailsFromJson(orderDetailsToJson(details))
          .orderList.single.productqnty, '2');
    });

    test('cart list helpers support empty responses', () {
      expect(cartFromJson('[]'), isEmpty);
      expect(cartToJson(<Cart>[]), '[]');
    });
  });
}