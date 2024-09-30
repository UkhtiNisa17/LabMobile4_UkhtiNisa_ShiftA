import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK NISA";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  @override
  void dispose() {
    // Membersihkan controller untuk menghindari kebocoran memori
    _kodeProdukTextboxController.dispose();
    _namaProdukTextboxController.dispose();
    _hargaProdukTextboxController.dispose();
    super.dispose();
  }

  // Mengecek apakah ini form untuk menambah atau mengubah produk
  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK NISA";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK NISA";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                const SizedBox(height: 20),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return "Harga harus berupa angka positif";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return _isLoading
        ? const CircularProgressIndicator() // Menampilkan loading saat proses berjalan
        : OutlinedButton(
            child: Text(tombolSubmit),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submitForm();
              }
            },
          );
  }

  // Fungsi untuk submit form (Simpan/Ubah Produk)
  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    // Simulasi proses penyimpanan produk (misal API call)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              widget.produk != null ? 'Produk diubah' : 'Produk ditambahkan')),
    );

    // Setelah berhasil simpan/ubah, Anda bisa tambahkan logika navigasi atau lainnya
    Navigator.pop(context); // Contoh: kembali ke halaman sebelumnya
  }
}
