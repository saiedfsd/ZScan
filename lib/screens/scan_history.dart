import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../database/db_helper.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({super.key});

  @override
  State<ScanHistory> createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  List<Map<String, dynamic>> _scannedBarcodes = [];

  @override
  void initState() {
    super.initState();
    _loadBarcodes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _scannedBarcodes.isEmpty
          ? Center(
              child: Text('No Barcode Found!', style: TextStyle(fontSize: 18, color: Colors.teal)),
            )
          : ListView.builder(
              itemCount: _scannedBarcodes.length,
              itemBuilder: (context, index) {
                final scannedBarcode = _scannedBarcodes[index];
                return Dismissible(
                  key: Key(scannedBarcode['id'].toString()),
                  background: Container(
                    color: Colors.redAccent,
                    padding: EdgeInsets.only(right: 12),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await _showDeleteConfirmationDialog(context);
                  },
                  onDismissed: (direction) {
                    _deleteBarcode(scannedBarcode['id']);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Barcode Deleted')));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: Icon(Icons.qr_code, color: Colors.teal),
                      title: Text(
                        scannedBarcode['content'],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(
                            icon: Icon(Icons.copy, color: Colors.grey[700]),
                            onPressed: () {
                              _copyToClipboard(scannedBarcode['content']);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.share, color: Colors.grey[700]),
                            onPressed: () {
                              _shareResult(scannedBarcode['content']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _loadBarcodes() async {
    final barcodes = await DbHelper.getBarcodes();
    setState(() {
      _scannedBarcodes = barcodes!;
    });
  }

  Future<void> _deleteBarcode(int id) async {
    await DbHelper.deleteBarcode(id);
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Delete Barcode'),
          content: Text('Are you sure to delete this barcode?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Colors.redAccent
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _shareResult(String result) {
    Share.share(result);
  }

  void _copyToClipboard(String result) {
    Clipboard.setData(ClipboardData(text: result));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Barcode Copied!")));
  }
}
