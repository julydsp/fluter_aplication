import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/pegawai_service.dart';
import 'pegawai_detail.dart';
import 'package:intl/intl.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipPegawaiCtrl = TextEditingController();
  final _namaPegawaiCtrl = TextEditingController();
  final _tanggallahirPegawaiCtrl = TextEditingController();
  final _nomorteleponPegawaiCtrl = TextEditingController();
  final _emailPegawaiCtrl = TextEditingController();
  final _passwordPegawaiCtrl = TextEditingController();

  Future<Pegawai> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      if (data.nipPegawai != null) {
        _nipPegawaiCtrl.text = data.nipPegawai;
      }
      if (data.namaPegawai != null) {
        _namaPegawaiCtrl.text = data.namaPegawai;
      }
      if (data.tanggallahirPegawai != null) {
        final formattedDate =
        "${data.tanggallahirPegawai.year}-${data.tanggallahirPegawai.month.toString().padLeft(2, '0')}-${data.tanggallahirPegawai.day.toString().padLeft(2, '0')}";
        _tanggallahirPegawaiCtrl.text = formattedDate;
      }
      if (data.nomorteleponPegawai != null) {
        _nomorteleponPegawaiCtrl.text = data.nomorteleponPegawai;
      }
      if (data.emailPegawai != null) {
        _emailPegawaiCtrl.text = data.emailPegawai;
      }
      if (data.passwordPegawai != null) {
        _passwordPegawaiCtrl.text = data.passwordPegawai;
      }
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaPegawai(),
              _fieldNipPegawai(),
              _fieldtanggallahirPegawai(),
              _fieldnomorteleponPegawai(),
              _fieldemailPegawai(),
              _fieldpasswordPegawai(),
              SizedBox(height: 20), 
              _tombolSimpan()],
          ),
        ),
      ),
    );
  }

  _fieldNipPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: _nipPegawaiCtrl,
    );
  }
  
  _fieldNamaPegawai() {
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Poli"),
      controller: _namaPegawaiCtrl,
    );
  }
  
  _fieldtanggallahirPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tgl Lahir Pegawai"),
      controller: _tanggallahirPegawaiCtrl,
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          setState(() {
            _tanggallahirPegawaiCtrl.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap pilih Tgl Lahir Pegawai';
        }
        return null;
      },
    );
  }
  
  _fieldnomorteleponPegawai(){
    return TextField(
      decoration: const InputDecoration(labelText: "Nomor telepon pegawai"),
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
        Pegawai pegawai = new Pegawai(
          nipPegawai: _nipPegawaiCtrl.text,
          namaPegawai: _namaPegawaiCtrl.text,
          tanggallahirPegawai: DateTime.parse(_tanggallahirPegawaiCtrl.text),
          nomorteleponPegawai: _nomorteleponPegawaiCtrl.text,
          emailPegawai: _emailPegawaiCtrl.text,
          passwordPegawai: _passwordPegawaiCtrl.text);
        String id = widget.pegawai.id.toString();
        await PegawaiService().ubah(pegawai, id).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => pegawaidetail(pegawai: value),
            ),
          );
        });
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
