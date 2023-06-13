import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/pegawai_service.dart';
import 'pegawai_detail.dart';
import 'package:intl/intl.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);
  _PegawaiFormState createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipPegawaiCtrl = TextEditingController();
  final _namaPegawaiCtrl = TextEditingController();
  final _tanggallahirPegawaiCtrl = TextEditingController();
  final _nomorteleponPegawaiCtrl = TextEditingController();
  final _emailPegawaiCtrl = TextEditingController();
  final _passwordPegawaiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
            _fieldnipPegawai(), 
            _fieldnamaPegawai(), 
            _fieldtanggallahirPegawai(), 
            _fieldnomorteleponPegawai(), 
            _fieldemailPegawai(),
            _fieldpasswordPegawai(), 
            SizedBox(height: 20) , _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldnipPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nip Pegawai"),
      controller: _nipPegawaiCtrl,
    );
  }
  _fieldnamaPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
    );
  }
  _fieldtanggallahirPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir Pegawai"),
      controller: _tanggallahirPegawaiCtrl,
    );
  }
  _fieldnomorteleponPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor telepon Pegawai"),
      controller: _nomorteleponPegawaiCtrl,
    );
  }
  _fieldemailPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Email Pegawai"),
      controller: _emailPegawaiCtrl,
    );
  }
  _fieldpasswordPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Password Pegawai"),
      controller: _passwordPegawaiCtrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        String formattedDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(_tanggallahirPegawaiCtrl.text));
          Pegawai pegawai = Pegawai(
          nipPegawai: _nipPegawaiCtrl.text,
          namaPegawai: _namaPegawaiCtrl.text,
          tanggallahirPegawai: DateTime.parse(formattedDate),
          nomorteleponPegawai: _nomorteleponPegawaiCtrl.text,
          emailPegawai: _emailPegawaiCtrl.text,
          passwordPegawai:_passwordPegawaiCtrl.text);
        
        await PegawaiService().simpan(pegawai).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => pegawaidetail(pegawai: value),
            ),
          );
        });
      },
      child: const Text("Simpan"),
    );
  }
}
