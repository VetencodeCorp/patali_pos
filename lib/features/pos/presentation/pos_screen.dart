import 'dart:ui';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/app_settings_repository.dart';
import '../../../data/repositories/cash_session_repository.dart';
import '../../../data/repositories/cashier_settings_repository.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../../data/repositories/payment_settings_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../shared/widgets/patali_shell.dart';
import '../../customers/presentation/customer_management_screen.dart';
import '../../orders/presentation/order_history_screen.dart';
import '../../orders/presentation/receipt_screen.dart';
import '../application/cart_controller.dart';
import '../application/cash_session_controller.dart';
import '../application/checkout_controller.dart';

const _ink = Color(0xFF17211F);
const _muted = Color(0xFF73807B);
const _surface = Color(0xFFFFFFFF);
const _surfaceTint = Color(0xFFF7FBF8);
const _border = Color(0xFFE2ECE7);
const _brand = Color(0xFF16725F);
const _mint = Color(0xFFE8F7F1);

class PosScreen extends ConsumerWidget {
  const PosScreen({super.key});

  static const routePath = '/pos';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(filteredProductsProvider);
    final categories = ref.watch(activeCategoriesProvider);
    final cashSession = ref.watch(activeCashSessionProvider);
    final cartItems = ref.watch(cartControllerProvider);
    ref.listen(cashierSettingsProvider, (previous, next) {
      next.whenData((settings) {
        final hasCart = ref.read(cartControllerProvider).isNotEmpty;
        if (hasCart) return;
        ref.read(selectedPaymentMethodProvider.notifier).state =
            settings.defaultPaymentMethod;
        ref.read(selectedOrderTypeProvider.notifier).state =
            settings.defaultOrderType;
      });
    });
    ref.listen(paymentSettingsProvider, (previous, next) {
      next.whenData((settings) {
        final active = activePaymentMethods(settings);
        final selected = ref.read(selectedPaymentMethodProvider);
        if (!active.contains(selected)) {
          ref.read(selectedPaymentMethodProvider.notifier).state = 'cash';
        }
      });
    });

    return PataliShell(
      title: 'Patali POS',
      currentIndex: 0,
      actions: [
        cashSession.when(
          data: (session) => Padding(
            padding: const EdgeInsets.only(right: 6),
            child: TextButton.icon(
              onPressed: () => _toggleSession(context, ref, session),
              icon: Icon(session == null ? Icons.lock_open : Icons.lock),
              label: Text(session == null ? 'Buka' : 'Tutup'),
            ),
          ),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          error: (error, stackTrace) => IconButton(
            tooltip: 'Status kasir gagal dimuat',
            onPressed: null,
            icon: const Icon(Icons.error_outline),
          ),
        ),
      ],
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xFFF6FAF8)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 980;
            final session = cashSession.valueOrNull;
            final categoryFilter = categories.when(
              data: (items) => _CategoryFilter(categories: items),
              loading: () => const SizedBox(height: 60),
              error: (error, stackTrace) =>
                  _InlineError(message: 'Kategori gagal dimuat: $error'),
            );
            final productGrid = products.when(
              data: (items) => _ProductGrid(products: items, wide: wide),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  _InlineError(message: 'Gagal memuat produk: $error'),
            );

            final productArea = Column(
              children: [
                _PosHeader(session: session, cartItems: cartItems),
                if (wide || cartItems.isEmpty) const _SearchBar(),
                if (wide || cartItems.isEmpty) categoryFilter,
                Expanded(child: productGrid),
              ],
            );

            if (wide) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Row(
                  children: [
                    Expanded(flex: 7, child: productArea),
                    const SizedBox(width: 16),
                    const SizedBox(width: 390, child: _CartPanel(wide: true)),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                    child: productArea,
                  ),
                ),
                const _MobilePosActionBar(),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _toggleSession(
    BuildContext context,
    WidgetRef ref,
    CashSession? session,
  ) async {
    try {
      if (session == null) {
        final openingCash = await _showMoneyDialog(
          context: context,
          title: 'Buka kasir',
          label: 'Modal awal',
          confirmLabel: 'Buka',
        );
        if (openingCash == null) return;

        await ref
            .read(cashSessionControllerProvider.notifier)
            .openSession(openingCash: openingCash);
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Kasir dibuka')));
        return;
      }

      final closingCash = await _showMoneyDialog(
        context: context,
        title: 'Tutup kasir',
        label: 'Uang fisik',
        confirmLabel: 'Tutup',
      );
      if (closingCash == null) return;

      await ref
          .read(cashSessionControllerProvider.notifier)
          .closeSession(sessionId: session.id, closingCash: closingCash);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Kasir ditutup')));
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal update kasir: $error')));
    }
  }

  Future<int?> _showMoneyDialog({
    required BuildContext context,
    required String title,
    required String label,
    required String confirmLabel,
  }) {
    final controller = TextEditingController(text: '0');

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: label, prefixText: 'Rp '),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                final value = _parseMoney(controller.text);
                Navigator.of(context).pop(value);
              },
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );
  }
}

int _parseMoney(String value) {
  return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}

class _PosHeader extends StatelessWidget {
  const _PosHeader({required this.session, required this.cartItems});

  final CashSession? session;
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final isOpen = session != null;

    return _GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _brand,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.hub, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patali Demo Outlet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isOpen
                      ? 'Kasir sedang buka - modal ${currency.format(session!.openingCash)}'
                      : 'Buka kasir untuk checkout',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isOpen
                        ? _brand
                        : Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _MetricPill(
            label: '${cartItems.totalQty} item',
            value: currency.format(cartItems.grandTotal(0)),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  const _SearchBar();

  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(productSearchQueryProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                ref.read(productSearchQueryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                hintText: 'Cari produk, SKU, atau barcode',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Hapus pencarian',
                        onPressed: () {
                          _controller.clear();
                          ref.read(productSearchQueryProvider.notifier).state =
                              '';
                          FocusScope.of(context).unfocus();
                        },
                        icon: const Icon(Icons.close),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 48,
            width: 52,
            child: FilledButton(
              onPressed: () => _showBarcodeDialog(context, ref),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: _ink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Icon(Icons.qr_code_scanner),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showBarcodeDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Scan Barcode'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Barcode / SKU',
              hintText: 'Contoh: 8991234567890',
            ),
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (code == null || code.trim().isEmpty || !context.mounted) return;

    final normalized = code.trim().toLowerCase();
    final products = await ref.read(activeProductsProvider.future);
    Product? matched;
    for (final product in products) {
      final barcode = product.barcode?.trim().toLowerCase();
      final sku = product.sku?.trim().toLowerCase();
      if (barcode == normalized || sku == normalized) {
        matched = product;
        break;
      }
    }

    if (!context.mounted) return;
    if (matched == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk barcode $code tidak ditemukan')),
      );
      return;
    }
    if (matched.trackStock && matched.stockQty <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Stok ${matched.name} habis')));
      return;
    }
    ref.read(cartControllerProvider.notifier).addProduct(matched);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${matched.name} masuk cart')));
  }
}

class _CategoryFilter extends ConsumerWidget {
  const _CategoryFilter({required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedCategoryIdProvider);

    return SizedBox(
      height: 60,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('Semua'),
              selected: selectedId == null,
              onSelected: (_) {
                ref.read(selectedCategoryIdProvider.notifier).state = null;
              },
            ),
          ),
          for (final category in categories)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(category.name),
                selected: selectedId == category.id,
                onSelected: (_) {
                  ref.read(selectedCategoryIdProvider.notifier).state =
                      category.id;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductGrid extends ConsumerWidget {
  const _ProductGrid({required this.products, required this.wide});

  final List<Product> products;
  final bool wide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(productSearchQueryProvider);
    if (products.isEmpty) {
      return Center(
        child: Text(
          query.trim().isEmpty
              ? 'Belum ada produk'
              : 'Produk "${query.trim()}" tidak ditemukan',
          textAlign: TextAlign.center,
        ),
      );
    }

    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: wide ? 4 : 2,
        childAspectRatio: wide ? 1.35 : 1.02,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        final outOfStock = product.trackStock && product.stockQty <= 0;
        return _GlassPanel(
          onTap: () {
            if (outOfStock) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Stok ${product.name} habis')),
              );
              return;
            }
            ref.read(cartControllerProvider.notifier).addProduct(product);
          },
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 42,
                      height: 42,
                      color: _mint,
                      child:
                          product.imagePath == null ||
                              product.imagePath!.isEmpty
                          ? const Icon(
                              Icons.restaurant_menu,
                              color: _brand,
                              size: 19,
                            )
                          : Image.file(
                              File(product.imagePath!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.restaurant_menu,
                                    color: _brand,
                                    size: 19,
                                  ),
                            ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.add_circle, color: _brand, size: 23),
                ],
              ),
              const Spacer(),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currency.format(product.price),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: outOfStock ? _muted : _brand,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (product.trackStock) ...[
                const SizedBox(height: 4),
                Text(
                  outOfStock ? 'Stok habis' : 'Stok ${product.stockQty}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: outOfStock
                        ? Theme.of(context).colorScheme.error
                        : _muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _MobilePosActionBar extends ConsumerWidget {
  const _MobilePosActionBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartControllerProvider);
    final orderType = ref.watch(selectedOrderTypeProvider);
    final selectedCustomerId = ref.watch(selectedCustomerIdProvider);
    final selectedCustomer = selectedCustomerId == null
        ? null
        : ref.watch(customerByIdProvider(selectedCustomerId)).valueOrNull;
    final discount = ref.watch(cartDiscountProvider);
    final settings = ref.watch(appSettingsProvider).valueOrNull;
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final total = _calculateCartTotal(cartItems, discount, settings);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: _surface.withValues(alpha: 0.94),
          border: const Border(top: BorderSide(color: _border)),
          boxShadow: [
            BoxShadow(
              color: _ink.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 62,
              child: Row(
                children: [
                  _MobileActionButton(
                    icon: Icons.more_horiz,
                    label: '',
                    onTap: () {},
                  ),
                  _MobileActionButton(
                    icon: Icons.person_add_alt_1_outlined,
                    label: selectedCustomer?.name ?? 'Pelanggan',
                    onTap: () => _showCustomerPicker(context, ref),
                  ),
                  _MobileActionButton(
                    icon: Icons.room_service_outlined,
                    label: orderType,
                    onTap: () => _showOrderTypeSheet(context, ref),
                  ),
                  _MobileActionButton(
                    icon: Icons.receipt_long_outlined,
                    label: 'Daftar Order',
                    onTap: () => context.go(OrderHistoryScreen.routePath),
                  ),
                ],
              ),
            ),
            Material(
              color: const Color(0xFFF2F5F3),
              child: InkWell(
                onTap: () => _showCartSheet(context),
                child: SizedBox(
                  height: 72,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${cartItems.totalQty} Produk',
                            style: TextStyle(
                              color: cartItems.isEmpty ? _muted : _ink,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          currency.format(total),
                          style: TextStyle(
                            color: cartItems.isEmpty ? _muted : _ink,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.chevron_right, color: _muted),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCartSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.72,
          minChildSize: 0.38,
          maxChildSize: 0.92,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(12),
              child: const _CartPanel(wide: false),
            );
          },
        );
      },
    );
  }

  Future<void> _showOrderTypeSheet(BuildContext context, WidgetRef ref) {
    const options = [
      (Icons.table_restaurant_outlined, 'Meja'),
      (Icons.event_seat_outlined, 'Free Table'),
      (Icons.takeout_dining_outlined, 'Bungkus'),
      (Icons.local_shipping_outlined, 'Pengiriman'),
      (Icons.delivery_dining_outlined, 'Ojek Online'),
      (Icons.timer_outlined, 'Quick Service'),
      (Icons.event_available_outlined, 'Reservasi'),
    ];

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Text(
                'Jenis Order',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              for (final (icon, label) in options)
                ListTile(
                  leading: Icon(icon),
                  title: Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  onTap: () {
                    ref.read(selectedOrderTypeProvider.notifier).state = label;
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _MobileActionButton extends StatelessWidget {
  const _MobileActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: _border)),
            ),
            child: Center(
              child: label.isEmpty
                  ? Icon(icon, color: _brand)
                  : Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _brand,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartPanel extends ConsumerWidget {
  const _CartPanel({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartControllerProvider);
    final discountTotal = ref.watch(cartDiscountProvider);
    final paymentMethod = ref.watch(selectedPaymentMethodProvider);
    final checkoutState = ref.watch(checkoutControllerProvider);
    final cashSession = ref.watch(activeCashSessionProvider).valueOrNull;
    final settings = ref.watch(appSettingsProvider).valueOrNull;
    final cashierSettings = ref.watch(cashierSettingsProvider).valueOrNull;
    final paymentSettings = ref.watch(paymentSettingsProvider).valueOrNull;
    final manualDiscountEnabled =
        cashierSettings?.manualDiscountEnabled ?? true;
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final subtotal = cartItems.subtotal;
    final safeDiscount = discountTotal.clamp(0, subtotal);
    final taxableAmount = subtotal - safeDiscount;
    final taxTotal = settings?.taxEnabled ?? false
        ? (taxableAmount * settings!.taxRate / 100).round()
        : 0;
    final serviceTotal = settings?.serviceEnabled ?? false
        ? (taxableAmount * settings!.serviceRate / 100).round()
        : 0;
    final grandTotal = taxableAmount + taxTotal + serviceTotal;

    if (!wide && cartItems.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
        child: _GlassPanel(
          blur: true,
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Belum ada item',
                  style: TextStyle(color: _muted, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                currency.format(0),
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _GlassPanel(
      blur: true,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: wide ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _ink,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Cart',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: _ink,
                  ),
                ),
              ),
              if (cartItems.isNotEmpty)
                IconButton(
                  tooltip: 'Kosongkan',
                  onPressed: () {
                    ref.read(cartControllerProvider.notifier).clear();
                    ref.read(cartDiscountProvider.notifier).state = 0;
                    ref.read(selectedPaymentMethodProvider.notifier).state =
                        cashierSettings?.defaultPaymentMethod ?? 'cash';
                    ref.read(selectedOrderTypeProvider.notifier).state =
                        cashierSettings?.defaultOrderType ?? 'Bungkus';
                    ref.read(selectedCustomerIdProvider.notifier).state = null;
                  },
                  icon: const Icon(Icons.delete_sweep_outlined),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (cartItems.isEmpty)
            _EmptyCart(wide: wide)
          else if (!wide)
            Column(
              children: [
                for (final (index, item) in cartItems.indexed) ...[
                  if (index > 0) const SizedBox(height: 8),
                  _CartItemTile(item: item, currency: currency),
                ],
              ],
            )
          else
            Flexible(
              fit: FlexFit.tight,
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _CartItemTile(item: item, currency: currency);
                },
              ),
            ),
          if (wide && cartItems.isEmpty) const Spacer(),
          if (!wide) const SizedBox(height: 14),
          const Divider(height: 24),
          _CustomerSelectorRow(enabled: cartItems.isNotEmpty),
          const SizedBox(height: 8),
          _CartAmountRow(
            label: 'Subtotal (${cartItems.totalQty} item)',
            value: currency.format(subtotal),
          ),
          const SizedBox(height: 8),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: cartItems.isEmpty || !manualDiscountEnabled
                ? null
                : () => _showDiscountDialog(
                    context: context,
                    ref: ref,
                    currentDiscount: safeDiscount,
                    subtotal: subtotal,
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _CartAmountRow(
                label: 'Diskon',
                value: safeDiscount == 0
                    ? manualDiscountEnabled
                          ? 'Tambah'
                          : 'Nonaktif'
                    : '-${currency.format(safeDiscount)}',
                valueColor: safeDiscount == 0 && manualDiscountEnabled
                    ? _brand
                    : _ink,
                trailingIcon: manualDiscountEnabled
                    ? Icons.edit_outlined
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (taxTotal > 0) ...[
            _CartAmountRow(
              label: 'Pajak (${settings!.taxRate}%)',
              value: currency.format(taxTotal),
            ),
            const SizedBox(height: 8),
          ],
          if (serviceTotal > 0) ...[
            _CartAmountRow(
              label: 'Service (${settings!.serviceRate}%)',
              value: currency.format(serviceTotal),
            ),
            const SizedBox(height: 8),
          ],
          _CartAmountRow(
            label: 'Total',
            value: currency.format(grandTotal),
            emphasized: true,
          ),
          const SizedBox(height: 12),
          _PaymentMethodSelector(enabled: cartItems.isNotEmpty),
          if (paymentMethod == 'qris') ...[
            const SizedBox(height: 12),
            _QrisPaymentPanel(settings: paymentSettings),
          ],
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed:
                cartItems.isEmpty ||
                    checkoutState.isLoading ||
                    cashSession == null
                ? null
                : () async {
                    try {
                      final order = await ref
                          .read(checkoutControllerProvider.notifier)
                          .checkout(paymentMethod: paymentMethod);
                      if (!context.mounted) return;
                      final methodLabel = _paymentMethodLabel(paymentMethod);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Checkout $methodLabel berhasil: ${order.orderNumber}',
                          ),
                        ),
                      );
                      context.push(ReceiptScreen.location(order.id));
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Checkout gagal: $error')),
                      );
                    }
                  },
            icon: const Icon(Icons.payments_outlined),
            label: Text(checkoutState.isLoading ? 'Memproses' : 'Checkout'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDiscountDialog({
    required BuildContext context,
    required WidgetRef ref,
    required int currentDiscount,
    required int subtotal,
  }) async {
    final controller = TextEditingController(text: currentDiscount.toString());
    final value = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Diskon transaksi'),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nominal diskon',
              prefixText: 'Rp ',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(0),
              child: const Text('Hapus'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(_parseMoney(controller.text));
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (value == null) return;
    ref.read(cartDiscountProvider.notifier).state = value.clamp(0, subtotal);
  }
}

const _paymentMethods = [
  ('cash', 'Tunai', Icons.payments_outlined),
  ('qris', 'QRIS', Icons.qr_code_2),
  ('debit', 'Debit', Icons.credit_card),
  ('transfer', 'Transfer', Icons.account_balance),
];

String _paymentMethodLabel(String method) {
  return switch (method) {
    'cash' => 'tunai',
    'qris' => 'QRIS',
    'debit' => 'debit',
    'transfer' => 'transfer',
    _ => method,
  };
}

int _calculateCartTotal(
  List<CartItem> items,
  int discount,
  AppSetting? settings,
) {
  final subtotal = items.subtotal;
  final safeDiscount = discount.clamp(0, subtotal);
  final taxableAmount = subtotal - safeDiscount;
  final taxTotal = settings?.taxEnabled ?? false
      ? (taxableAmount * settings!.taxRate / 100).round()
      : 0;
  final serviceTotal = settings?.serviceEnabled ?? false
      ? (taxableAmount * settings!.serviceRate / 100).round()
      : 0;
  return taxableAmount + taxTotal + serviceTotal;
}

class _PaymentMethodSelector extends ConsumerWidget {
  const _PaymentMethodSelector({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedPaymentMethodProvider);
    final paymentSettings = ref.watch(paymentSettingsProvider).valueOrNull;
    final activeMethods = activePaymentMethods(paymentSettings);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (method, label, icon) in _paymentMethods)
          if (activeMethods.contains(method))
            ChoiceChip(
              avatar: Icon(icon, size: 17),
              label: Text(label),
              selected: selected == method,
              onSelected: enabled
                  ? (_) {
                      ref.read(selectedPaymentMethodProvider.notifier).state =
                          method;
                    }
                  : null,
            ),
      ],
    );
  }
}

class _CustomerSelectorRow extends ConsumerWidget {
  const _CustomerSelectorRow({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerId = ref.watch(selectedCustomerIdProvider);
    final customer = customerId == null
        ? null
        : ref.watch(customerByIdProvider(customerId)).valueOrNull;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: enabled ? () => _showCustomerPicker(context, ref) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: _CartAmountRow(
          label: 'Pelanggan',
          value: customer?.name ?? 'Walk-in',
          valueColor: _brand,
          trailingIcon: Icons.person_search_outlined,
        ),
      ),
    );
  }
}

Future<void> _showCustomerPicker(BuildContext context, WidgetRef ref) async {
  final selectedId = ref.read(selectedCustomerIdProvider);
  final customers = await ref.read(activeCustomersProvider.future);
  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) {
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          children: [
            Text(
              'Pilih Pelanggan',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text(
                'Walk-in Customer',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              trailing: selectedId == null ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(selectedCustomerIdProvider.notifier).state = null;
                Navigator.of(context).pop();
              },
            ),
            for (final customer in customers)
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: Text(
                  customer.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: customer.phone == null ? null : Text(customer.phone!),
                trailing: selectedId == customer.id
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  ref.read(selectedCustomerIdProvider.notifier).state =
                      customer.id;
                  Navigator.of(context).pop();
                },
              ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                context.push(CustomerManagementScreen.routePath);
              },
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: const Text('Kelola Pelanggan'),
            ),
          ],
        ),
      );
    },
  );
}

class _QrisPaymentPanel extends StatelessWidget {
  const _QrisPaymentPanel({required this.settings});

  final PaymentSetting? settings;

  @override
  Widget build(BuildContext context) {
    final imagePath = settings?.qrisImagePath;
    final provider = settings?.qrisProvider;
    final instruction = settings?.qrisInstruction;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surfaceTint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.qr_code_2, color: _brand, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  provider?.trim().isEmpty ?? true ? 'QRIS Manual' : provider!,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 190,
              color: Colors.white,
              child: imagePath == null || imagePath.isEmpty
                  ? const Center(
                      child: Text(
                        'Foto QRIS belum diatur',
                        style: TextStyle(
                          color: _muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : Image.file(
                      File(imagePath),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Text(
                              'QRIS tidak bisa dibuka',
                              style: TextStyle(
                                color: _muted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                    ),
            ),
          ),
          if (instruction != null && instruction.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              instruction,
              style: const TextStyle(
                color: _muted,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartAmountRow extends StatelessWidget {
  const _CartAmountRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.valueColor,
    this.trailingIcon,
  });

  final String label;
  final String value;
  final bool emphasized;
  final Color? valueColor;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final labelStyle = emphasized
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
            color: _ink,
            fontWeight: FontWeight.w900,
          )
        : const TextStyle(color: _muted, fontWeight: FontWeight.w700);
    final valueStyle = emphasized
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
            color: _ink,
            fontWeight: FontWeight.w900,
          )
        : TextStyle(color: valueColor ?? _ink, fontWeight: FontWeight.w800);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: valueStyle),
            if (trailingIcon != null) ...[
              const SizedBox(width: 6),
              Icon(trailingIcon, size: 16, color: _muted),
            ],
          ],
        ),
      ],
    );
  }
}

class _CartItemTile extends ConsumerWidget {
  const _CartItemTile({required this.item, required this.currency});

  final CartItem item;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cartControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surfaceTint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currency.format(item.lineTotal),
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _QtyButton(
            tooltip: 'Kurangi',
            icon: Icons.remove,
            onPressed: () => controller.decreaseQty(item.product.id),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${item.qty}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          _QtyButton(
            tooltip: 'Tambah',
            icon: Icons.add,
            onPressed: () => controller.addProduct(item.product),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: _border),
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 34, height: 34),
        icon: Icon(icon, size: 18, color: _brand),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.onTap,
    this.blur = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    final panel = ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: blur
            ? ImageFilter.blur(sigmaX: 14, sigmaY: 14)
            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: padding,
          decoration: BoxDecoration(
            color: _surface.withValues(alpha: 0.86),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _border),
            boxShadow: [
              BoxShadow(
                color: _brand.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    if (onTap == null) return panel;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: panel,
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 132),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: _mint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _brand.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _brand,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wide ? 160 : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceTint,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
      ),
      child: const Center(
        child: Text(
          'Belum ada item',
          style: TextStyle(color: _muted, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(24), child: Text(message)),
    );
  }
}
