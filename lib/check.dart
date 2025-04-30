import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ThermalPrinterConnectivity extends StatefulWidget {
  const ThermalPrinterConnectivity({super.key});

  @override
  State<ThermalPrinterConnectivity> createState() => _ThermalPrinterConnectivityState();
}

class _ThermalPrinterConnectivityState extends State<ThermalPrinterConnectivity> {
  TextEditingController ipController = TextEditingController();
  Future<List<int>> connectionBuild() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.emptyLines(2);
    bytes += generator.text(
      'Connection Build',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        width: PosTextSize.size2,
      ),
    );
    bytes += generator.emptyLines(2);
    bytes += generator.text(
      'Printer successfully connected. by Qsr Team',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      'Suleman Ahmad',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      'Zain Asif',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.emptyLines(2);
    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  Future<void> printTicket(List<int> ticket, {String? ip, int? port}) async {
    final printer = PrinterNetworkManager(ipController.text.trim(), port: 9100);
    PosPrintResult connect = await printer.connect();
    if (connect.msg.contains('Success')) {
      print('connected successfully');
    }
    if (connect == PosPrintResult.success) {
      PosPrintResult printing = await printer.printTicket(ticket);
      printer.disconnect();
    } else {
      Fluttertoast.showToast(
        msg: "Please ThermalPrinterConnectivity Printer Connection.",
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Printer Connection")),
      body: Column(
        children: [
          TextField(controller: ipController),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                // If the button is pressed, return green, otherwise blue

                return Colors.green;
              }),
            ),
            onPressed: () async {
              var res = await connectionBuild();
              print('connection status : ${res.toString()}');
              await printTicket(res, ip: ipController.text.trim(), port: 9100);
            },
            child: Text('Print'),
          ),
        ],
      ),
    );
  }
}
