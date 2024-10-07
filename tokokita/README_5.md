## Penjelasan kode

# 1. Register
![lampiran](register_succes.png)
- Input Registrasi: Pengguna memasukkan data pendaftaran, termasuk:
        Nama: "ukhti nisa"
        Email: "nisasa18@gmail.com"
        Password: Pengguna juga memasukkan password serta konfirmasi password.
- Pengiriman Data: Setelah pengguna mengisi form dan menekan tombol "Registrasi", data tersebut dikirimkan ke backend server untuk divalidasi dan disimpan ke dalam database.
- Proses Validasi & Penyimpanan:
        Backend memvalidasi data yang dimasukkan (misalnya apakah email sudah digunakan, apakah password sesuai, dsb.).
        Jika validasi berhasil, backend akan menyimpan data pengguna yang baru dalam database, sehingga pengguna terdaftar dalam sistem.
- Respon Sukses:
        Setelah server memproses dan berhasil menyimpan data registrasi, aplikasi frontend menampilkan dialog "SUKSES". Pesan ini menandakan bahwa registrasi telah berhasil, dan pengguna diminta untuk login dengan akun yang baru saja didaftarkan.

# 2. Login
  a.login success
  ![lampiran](login_succes.png)
  jika email dan password sesuai dengan yang didaftarkan sebelumnya pada saat regist maka login akan success dan langsung menuju pada halaman produk page hal ini terjadi melalui kode:
  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    }, onError: (error) {
      print(error);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    });

  
  b. gagal login
  ![lampiran](gagal_login.png)
gambar diatas menunjukan jika gagal login, Kesalahan ini menunjukkan bahwa proses login tidak dapat mengotentikasi pengguna, karena email atau kata sandi yang salah atau belum terdaftar. 
untuk kodenya =
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => const WarningDialog(
    description: "Login gagal, silahkan coba lagi",
  ),
);
Ini Ini cara cara menampilkan aplikasi pesan pesan kesalahan komponenWarningDialog. Pesan yang ditampilkan akan tetap sama terlepas dari apakah kegagalan disebabkan oleh server atau error dari sisi aplikasi (misalnya karena masalah jaringan).

# 3. List produk
![lampiran](listproduk_awal.png)
proses yang terjadi pada gambar diatas:
- ProdukPage memanggil data dari ProdukBloc.getProduks().
- Data tersebut diteruskan ke ListProduk untuk ditampilkan dalam bentuk list menggunakan ListView.builder.
- Setiap produk ditampilkan menggunakan ItemProduk, yang dalam kasus ini adalah Samsung TV 60 Inch.
- Tombol tambah di kanan atas memungkinkan pengguna untuk menambah produk baru dengan membuka halaman ProdukForm.
Bagian yang bertanggung jawab untuk menampilkan daftar produk ada pada class ListProduk dan ItemProduk.
    - ListProduk menerima data list produk dan membuat tampilan dinamis menggunakan ListView.builder.
    - ItemProduk bertugas untuk menampilkan setiap produk dalam bentuk Card yang memuat nama dan harga produk.
Seluruh daftar produk ditarik dari backend menggunakan FutureBuilder dan dipetakan ke widget ini untuk ditampilkan kepada pengguna.

# 4. Tambah produk
  a. tambah produk
  ![lampiran](tambahproduk.png)
  - Pengguna mengisi data produk (kode produk, nama produk, dan harga).
  - Saat tombol "SIMPAN" ditekan, data ini kemungkinan akan dikirim ke server atau database melalui API atau metode penyimpanan lokal (SharedPreferences dalam Flutter).
  - Setelah data tersimpan, sistem dapat memperbarui daftar produk yang ada di halaman lain atau memberikan notifikasi sukses kepada pengguna.
dari aplikasi Flutter yang Anda kembangkan, fungsi di balik tombol "SIMPAN" menggunakan async/await untuk berinteraksi dengan database atau backend.
- Tombol "SIMPAN":
Pada fungsi _buttonSubmit(), ada kondisi yang mengecek apakah widget.produk kosong atau tidak. Jika null, maka aplikasi akan menjalankan fungsi simpan() yang berarti aplikasi dalam mode penambahan produk baru. Tombol submit ini dihubungkan dengan validasi form yang memeriksa apakah semua input valid (seperti kode produk, nama produk, dan harga harus diisi).

- Fungsi simpan():
  Di dalam fungsi simpan(), sistem pertama-tama mengatur variabel _isLoading menjadi true untuk mengindikasikan bahwa proses sedang berlangsung.
    Produk baru dibuat menggunakan model Produk dengan memanfaatkan nilai-nilai yang dimasukkan ke dalam text field:
Produk createProduk = Produk(id: null);
createProduk.kodeProduk = _kodeProdukTextboxController.text;
createProduk.namaProduk = _namaProdukTextboxController.text;
createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);

Produk baru ini tidak memiliki id karena ini adalah data baru. Setelah itu, produk baru dikirim ke ProdukBloc.addProduk():

ProdukBloc.addProduk(produk: createProduk).then((value) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => const ProdukPage()));
}, onError: (error) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const WarningDialog(
      description: "Simpan gagal, silahkan coba lagi",
    ),
  );
});

Di sini, data produk dikirim ke dalam ProdukBloc untuk ditambahkan ke dalam sistem. Jika proses berhasil, pengguna akan diarahkan kembali ke ProdukPage (daftar produk). Jika gagal, sistem akan menampilkan dialog peringatan melalui WarningDialog.
Untuk menambahkan produk baru, kode yang bertanggung jawab adalah bagian:
    - Tombol SIMPAN yang memanggil fungsi simpan().
    - Fungsi simpan() membuat objek produk baru berdasarkan input dari pengguna dan mengirimnya ke ProdukBloc.addProduk() untuk disimpan di backend atau database.
    
  b. list produk setelah tambah produk
  ![lampiran](listproduk_tambahproduk.png)
  setelah menambahkan produk atau dengan mengklik simpan, produk akan bertambah pada bagian list produk.

# 5. Detail produk
![lampiran](detailproduk_sebelum.png)
- Navigasi ke Detail Produk:
Ketika pengguna memilih salah satu produk dari daftar produk pada halaman sebelumnya (List Produk Nisa), aplikasi memanggil halaman ProdukDetail.Halaman ini menerima data produk yang dipilih sebagai argumen (dalam hal ini, produk dengan kode A002).
- Menampilkan Detail Produk:
Di dalam halaman ProdukDetail, data produk (kode, nama, dan harga) diteruskan dan ditampilkan menggunakan Text widget pada layout.Gambar ini menunjukkan data produk Kipas Angin Advance dengan kode produk A002 dan harga Rp. 150.000.
- Tombol Edit:
Tombol EDIT mengarahkan pengguna ke halaman ProdukForm jika ditekan. Hal ini memungkinkan pengguna untuk mengubah data produk.Tombol ini menggunakan Navigator.push untuk membawa pengguna ke halaman form yang sudah berisi data produk yang dipilih (untuk proses update).
- Tombol Delete:
Tombol DELETE akan memicu proses penghapusan produk. Ketika tombol ini ditekan, biasanya akan ada konfirmasi terlebih dahulu sebelum menghapus data dari database atau API.Setelah produk dihapus, aplikasi bisa diarahkan kembali ke halaman daftar produk dengan menggunakan Navigator.pop atau push ke halaman daftar.
prosesnya:
    Pengguna melihat detail produk dari daftar produk sebelumnya.
    Tersedia tombol EDIT untuk mengubah data produk dan tombol DELETE untuk menghapus produk.
    Tombol EDIT membawa pengguna ke halaman form dengan data produk yang telah diisi, sementara tombol DELETE akan memicu proses penghapusan produk.

# 6. Ubah produk
  a. ubah produk kipas
  ![lampiran](ubahproduk.png)
  proses yang terjadi:
- Pengguna mengubah informasi produk (misalnya, mengganti nama, harga, atau kode produk) dalam contoh ini pengguna mengganti nama produk yang awalnya kipas angin advance menjadi kipas angin saja. Setelah mengedit, mereka menekan tombol "Ubah".
- Setelah pengguna mengirimkan form (dengan menekan tombol "Ubah"), aplikasi mengirimkan data yang telah diperbarui ke backend menggunakan ProdukBloc.updateProduk(), yang memperbarui produk di basis data.
- Setelah pembaruan berhasil, aplikasi mungkin mengarahkan pengguna kembali ke daftar produk (ProdukPage) atau menampilkan pesan sukses. Jika pembaruan gagal (misalnya, karena masalah jaringan), aplikasi akan menampilkan dialog kesalahan.
  b. detail produk setelah ubah produk
  ![lampiran](detailproduk_sesudah.png)
  setelah berhasil diubah otomatis detail produk juga akan berubah seperti disini kita mengubah nama produk yang awalnya Kipas Angin Advance menjadi kipas angin saja.
  c. list produk setelah diubah
  ![lampiran](listproduk_setubah.png)
  setelah diubah otomatis pada list produk berubah sama dengan detail produk yang sudah diubah diatas.
  
# 7. delete produk
  a. delete produk
  ![lampiran](delete.png)
Proses hapus melibatkan menampilkan dialog konfirmasi saat tombol hapus ditekan.
Jika dikonfirmasi, produk tersebut dihapus melalui ProdukBloc.deleteProduk().
Jika operasi berhasil, pengguna dialihkan ke daftar produk; jika tidak, pesan kesalahan ditampilkan.
  b. list produk setelah di delete
  ![lampiran](listproduk_awal.png)
  gambar diatas menunjukan list produk jika ada salah satu list produk yang sudah dihapus
