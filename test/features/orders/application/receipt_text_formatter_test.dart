import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/order_repository.dart';
import 'package:patali_pos/features/orders/application/receipt_text_formatter.dart';

void main() {
  test('formats receipt text in 32 columns', () {
    final now = DateTime(2026, 8, 22, 10, 0);
    final receipt = OrderReceipt(
      order: Order(
        id: 'order-1',
        customerId: 'cust-andi',
        orderNumber: 'INV-20260822-100000',
        status: 'completed',
        orderType: 'takeaway',
        subtotal: 36000,
        discountTotal: 0,
        taxTotal: 0,
        grandTotal: 36000,
        orderedAt: now,
        createdAt: now,
      ),
      items: [
        OrderItem(
          id: 'item-1',
          orderId: 'order-1',
          productName: 'Kopi Susu',
          qty: 2,
          unitPrice: 18000,
          discountTotal: 0,
          lineTotal: 36000,
          kitchenStatus: 'pending',
          createdAt: now,
        ),
      ],
      payments: [
        Payment(
          id: 'payment-1',
          orderId: 'order-1',
          method: 'cash',
          amount: 36000,
          status: 'paid',
          paidAt: now,
          createdAt: now,
        ),
      ],
      customer: Customer(
        id: 'cust-andi',
        name: 'Andi',
        isActive: true,
        createdAt: now,
      ),
    );

    final text = ReceiptTextFormatter().format(receipt);
    final lines = text.split('\n').where((line) => line.isNotEmpty);

    expect(text, contains('PATALI DEMO OUTLET'));
    expect(text, contains('Pelanggan: Andi'));
    expect(text, contains('Kopi Susu'));
    expect(text, contains('TOTAL                  Rp 36.000'));
    expect(lines.every((line) => line.length <= 32), isTrue);
  });
}
