import '../../../data/database/app_database.dart';
import '../../../data/repositories/order_repository.dart';

class ReceiptTextFormatter {
  ReceiptTextFormatter({this.columns = 32});

  final int columns;

  String format(OrderReceipt receipt, {AppSetting? settings}) {
    final outletName = settings?.outletName ?? 'Patali Demo Outlet';
    final header = settings?.receiptHeader;
    final footer = settings?.receiptFooter ?? 'Terima kasih';
    final address = settings?.showOutletAddress ?? true
        ? settings?.outletAddress
        : null;
    final phone = settings?.showOutletAddress ?? true
        ? settings?.outletPhone
        : null;

    final lines = <String>[
      _center(outletName.toUpperCase()),
      if (header != null && header.isNotEmpty) _center(header),
      if (address != null && address.isNotEmpty) _center(address),
      if (phone != null && phone.isNotEmpty) _center(phone),
      _line(),
      receipt.order.orderNumber,
      _date(receipt.order.orderedAt),
      _line(),
      for (final item in receipt.items) ...[
        _left(item.productName),
        _columns(
          '${item.qty} x ${_money(item.unitPrice)}',
          _money(item.lineTotal),
        ),
      ],
      _line(),
      _columns('Subtotal', _money(receipt.order.subtotal)),
      _columns('Diskon', _money(receipt.order.discountTotal)),
      _columns('Pajak/Service', _money(receipt.order.taxTotal)),
      _columns('TOTAL', _money(receipt.order.grandTotal)),
      _line(),
      for (final payment in receipt.payments)
        _columns(payment.method.toUpperCase(), _money(payment.amount)),
      _line(),
      _center(footer),
      '',
    ];

    return lines.join('\n');
  }

  String _center(String value) {
    final text = _clip(value);
    final leftPadding = ((columns - text.length) / 2).floor();
    return '${' ' * leftPadding}$text';
  }

  String _columns(String left, String right) {
    final safeRight = _clip(right);
    final maxLeft = columns - safeRight.length - 1;
    final safeLeft = _clip(left, maxLeft);
    final gap = columns - safeLeft.length - safeRight.length;
    return '$safeLeft${' ' * gap}$safeRight';
  }

  String _left(String value) => _clip(value);

  String _line() => '-' * columns;

  String _clip(String value, [int? maxLength]) {
    final limit = maxLength ?? columns;
    if (value.length <= limit) return value;
    if (limit <= 1) return value.substring(0, limit);
    return '${value.substring(0, limit - 1)}.';
  }

  String _money(int value) {
    final raw = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      final left = raw.length - i;
      buffer.write(raw[i]);
      if (left > 1 && left % 3 == 1) buffer.write('.');
    }
    return 'Rp $buffer';
  }

  String _date(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/'
        '${value.year} '
        '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }
}
