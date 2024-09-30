import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List<Produk> produkList = [
    Produk(
        id: 1, kodeProduk: 'A001', namaProduk: 'Kamera', hargaProduk: 5000000),
    Produk(
        id: 2, kodeProduk: 'A002', namaProduk: 'Kulkas', hargaProduk: 2500000),
    Produk(
        id: 3,
        kodeProduk: 'A003',
        namaProduk: 'Mesin Cuci',
        hargaProduk: 2000000),
  ];

  // Fungsi untuk menambahkan produk baru ke dalam list
  void addProduk(Produk produkBaru) {
    setState(() {
      produkList.add(produkBaru);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk Nisa'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                // Navigasi ke ProdukForm untuk menambahkan produk
                Produk? produkBaru = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukForm()),
                );
                // Jika produk baru ditambahkan, tambahkan ke dalam list
                if (produkBaru != null) {
                  addProduk(produkBaru);
                }
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () {
                // Tambahkan logika logout di sini
              },
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ItemProduk(produk: produkList[index]),
              const Divider(), // Divider untuk memberikan ruang antar produk
            ],
          );
        },
      ),
    );
  }
}

// Widget untuk menampilkan item produk
class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail produk
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(produk.namaProduk!),
          subtitle: Text("Rp. ${produk.hargaProduk.toString()}"),
        ),
      ),
    );
  }
}
