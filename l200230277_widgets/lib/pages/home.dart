import 'package:flutter/material.dart';

class TodoMenuItem {
  final String title;
  final IconData icon;
  TodoMenuItem({required this.title, required this.icon});
}

class Order {
  String item = '';
  int quantity = 0;
  String notes = '';
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final Order _order = Order();
  String _resultMessage = '';

  final List<TodoMenuItem> _menuList = [
    TodoMenuItem(title: 'Fast Food', icon: Icons.fastfood),
    TodoMenuItem(title: 'Remind Me', icon: Icons.add_alarm),
    TodoMenuItem(title: 'Flight', icon: Icons.flight),
    TodoMenuItem(title: 'Music', icon: Icons.audiotrack),
  ];

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _resultMessage =
            'Order saved! Item: ${_order.item}, Qty: ${_order.quantity}, Notes: ${_order.notes}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    int columnCount = orientation == Orientation.portrait ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('NIM Widgets'),
        actions: [
          PopupMenuButton<TodoMenuItem>(
            icon: const Icon(Icons.view_list),
            onSelected: (val) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Dipilih: ${val.title}')),
              );
            },
            itemBuilder: (context) {
              return _menuList.map((item) {
                return PopupMenuItem<TodoMenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(item.icon, color: Colors.lightGreen),
                      const SizedBox(width: 8),
                      Text(item.title),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.orange,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Box',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                RichText(
                  text: TextSpan(
                    text: 'Flutter ',
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.purple,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                    children: const [
                      TextSpan(
                        text: 'for ',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Mobile',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),

                const Text(
                  'Form Order',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Item',
                          hintText: 'Espresso',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Item wajib diisi';
                          }
                          return null;
                        },
                        onSaved: (value) => _order.item = value ?? '',
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          hintText: '3',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Quantity wajib diisi';
                          }
                          int? qty = int.tryParse(value.trim());
                          if (qty == null || qty <= 0) {
                            return 'Quantity harus angka lebih dari 0';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _order.quantity = int.tryParse(value ?? '0') ?? 0,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          hintText: 'Tanpa gula',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Notes wajib diisi';
                          }
                          return null;
                        },
                        onSaved: (value) => _order.notes = value ?? '',
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                          ),
                          onPressed: _submitOrder,
                          child: const Text(
                            'Save Order',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      if (_resultMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            _resultMessage,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),

                Text(
                  'Grid Orientasi ($columnCount kolom)',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Item ${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}