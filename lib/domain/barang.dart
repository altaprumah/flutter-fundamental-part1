class Barang {
  final int id;
  // ignore: non_constant_identifier_names
  final String nama_barang;
  final int harga;
  final String foto;
  final int stok;
  final double rating;
  final int terjual;
  final String deskripsi;
  final String kategori;

  const Barang({
    required this.id,
    // ignore: non_constant_identifier_names
    required this.nama_barang,
    required this.harga,
    required this.foto,
    required this.stok,
    required this.rating,
    this.terjual = 0,
    this.deskripsi = '',
    this.kategori = 'Sayuran',
  });

  // Alias getter untuk kepatuhan lowerCamelCase
  String get namaBarang => nama_barang;

  // Helper getter untuk format harga ke Rupiah
  String get hargaFormatted {
    return 'Rp ${harga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}