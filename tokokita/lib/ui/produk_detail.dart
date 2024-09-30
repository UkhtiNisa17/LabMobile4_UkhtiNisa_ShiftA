import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    // Cek jika produk null untuk menghindari error
    if (widget.produk == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk Nisa'),
        ),
        body: const Center(
          child: Text(
            'Produk tidak tersedia',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Nisa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Menyelaraskan teks ke kiri
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 8), // Menambahkan jarak antara teks
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20), // Jarak sebelum tombol
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  // Membuat tombol Hapus dan Edit
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk, // Mengirim data produk untuk di-edit
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Jarak antara tombol Edit dan Delete
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            // Tambahkan logika penghapusan di sini
            Navigator.pop(context); // Menutup dialog setelah hapus
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Produk berhasil dihapus'),
              ),
            );
            Navigator.pop(
                context); // Kembali ke halaman sebelumnya setelah menghapus
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context), // Menutup dialog
        ),
      ],
    );

    // Menampilkan dialog
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
