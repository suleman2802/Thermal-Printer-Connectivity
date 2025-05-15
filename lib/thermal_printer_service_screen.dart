import 'package:flutter/material.dart';
import 'thermal_printer_services.dart';

class ThermalPrinterConnectivityScreen extends StatelessWidget {
  ThermalPrinterConnectivityScreen({super.key});

  final TextEditingController ipController = TextEditingController(
    text: "192.168.1.2",
  );

  final ThermalPrinterServices thermalPrinterServices =
      ThermalPrinterServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Printer Connection")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: ipController),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  List<int> receiptBytes =
                      await thermalPrinterServices
                          .prepareConnectionBuildReceipt();
                  await thermalPrinterServices.printTicket(
                    receiptBytes,
                    ipController.text.trim(),
                    port: 9100,
                  );
                },
                child: Text('Print Connection Successful Receipt'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  List<int> receiptBytes =
                      await thermalPrinterServices.prepareSaleReceipt();

                  await thermalPrinterServices.printTicket(
                    receiptBytes,
                    ipController.text.trim(),
                    port: 9100,
                  );
                },
                child: Text('Print Sale Demo Receipt'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  List<int> receiptBytes =
                      await thermalPrinterServices.prepareKdsReceipt();
                  await thermalPrinterServices.printTicket(
                    receiptBytes,
                    ipController.text.trim(),
                    port: 9100,
                  );
                },
                child: Text('Print Kds Demo Receipt'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
