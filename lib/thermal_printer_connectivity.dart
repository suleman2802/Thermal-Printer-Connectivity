// import 'package:flutter/material.dart';
// import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
// import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class ThermalPrinterConnectivity extends StatefulWidget {
//   const ThermalPrinterConnectivity({super.key});

//   @override
//   State<ThermalPrinterConnectivity> createState() => _ThermalPrinterConnectivityState();
// }

// class _ThermalPrinterConnectivityState extends State<ThermalPrinterConnectivity> {
//   TextEditingController ipController = TextEditingController();
//   // Future<List<int>> connectionBuild() async {
//   //   final profile = await CapabilityProfile.load();
//   //   final generator = Generator(PaperSize.mm80, profile);
//   //   List<int> bytes = [];
//   //   bytes += generator.emptyLines(2);
//   //   bytes += generator.text(
//   //     'Connection Build',
//   //     styles: const PosStyles(
//   //       align: PosAlign.center,
//   //       bold: true,
//   //       width: PosTextSize.size2,
//   //     ),
//   //   );
//   //   bytes += generator.emptyLines(2);
//   //   bytes += generator.text(
//   //     'Printer successfully connected. by Qsr Team',
//   //     styles: const PosStyles(align: PosAlign.center),
//   //   );
//   //   bytes += generator.text(
//   //     'Suleman Ahmad',
//   //     styles: const PosStyles(align: PosAlign.center),
//   //   );
//   //   bytes += generator.text(
//   //     'Zain Asif',
//   //     styles: const PosStyles(align: PosAlign.center),
//   //   );
//   //   bytes += generator.emptyLines(2);
//   //   bytes += generator.feed(2);
//   //   bytes += generator.cut();
//   //   return bytes;
//   // }

//   Future<List<int>> connectionBuild() async {
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);
//     List<int> bytes = [];
//     bytes += generator.emptyLines(2);
//     bytes += generator.text(
//       'Connection Build',
//       styles: const PosStyles(
//         align: PosAlign.center,
//         bold: true,
//         width: PosTextSize.size2,
//       ),
//     );
//     bytes += generator.emptyLines(2);
//     bytes += generator.text(
//       'Printer successfully connected.',
//       styles: const PosStyles(align: PosAlign.center),
//     );

//     bytes += generator.emptyLines(2);
//     bytes += generator.feed(2);
//     bytes += generator.cut();
//     return bytes;
//   }
//   Future<void> printTicket(List<int> ticket, {String? ip, int? port}) async {
//     final printer = PrinterNetworkManager(ipController.text.trim(), port: 9100);
//     PosPrintResult connect = await printer.connect();
//     if (connect.msg.contains('Success')) {
//       print('connected successfully');
//     }
//     if (connect == PosPrintResult.success) {
//       PosPrintResult printing = await printer.printTicket(ticket);
//       printer.disconnect();
//     } else {
//       Fluttertoast.showToast(
//         msg: "Please ThermalPrinterConnectivity Printer Connection.",
//         gravity: ToastGravity.CENTER,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Printer Connection")),
//       body: Column(
//         children: [
//           TextField(controller: ipController),
//           ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.resolveWith((states) {
//                 // If the button is pressed, return green, otherwise blue

//                 return Colors.green;
//               }),
//             ),
//             onPressed: () async {
//               var res = await connectionBuild();
//               print('connection status : ${res.toString()}');
//               await printTicket(res, ip: ipController.text.trim(), port: 9100);
//             },
//             child: Text('Print'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//? need improvement
// import 'package:flutter/material.dart';
// import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
// import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class ThermalPrinterConnectivity extends StatefulWidget {
//   const ThermalPrinterConnectivity({super.key});

//   @override
//   State<ThermalPrinterConnectivity> createState() => _ThermalPrinterConnectivityState();
// }

// class _ThermalPrinterConnectivityState extends State<ThermalPrinterConnectivity> {
//   TextEditingController ipController = TextEditingController();

//   Future<List<int>> connectionBuild() async {
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);
//     List<int> bytes = [];

//     // Store Name
//     bytes += generator.text(
//       'Zaika To Go',
//       styles: const PosStyles(
//         align: PosAlign.center,
//         bold: true,
//         height: PosTextSize.size2,
//         width: PosTextSize.size2,
//       ),
//     );

//     bytes += generator.emptyLines(1);

//     // Order Header
//     bytes += generator.text(
//       'ORDER: 0047\n',
//       styles: const PosStyles(align: PosAlign.left),
//     );
//     bytes += generator.text(
//       'To Go Waiting\n',
//       styles: const PosStyles(align: PosAlign.left),
//     );

//     bytes += generator.emptyLines(1);

//     // Order Items
//     bytes += generator.text(
//       '1 MANGO LASSI          \$2.99\nRefunded: -\$2.99',
//       styles: const PosStyles(align: PosAlign.left),
//     );
//     bytes += generator.text(
//       '1 CHICKEN BIRYANI      \$8.99\nExchanged: \$8.99',
//       styles: const PosStyles(align: PosAlign.left),
//     );
//     bytes += generator.text(
//       '1 CHICKEN PULAO        \$8.99\nRefunded: -\$8.99',
//       styles: const PosStyles(align: PosAlign.left),
//     );

//     // Tax and Total
//     bytes += generator.emptyLines(1);
//     bytes += generator.text(
//       'Sales Tax: 8.25%  \$0.99',
//       styles: const PosStyles(align: PosAlign.left),
//     );
//     bytes += generator.text(
//       'Total: \$0.00',
//       styles: const PosStyles(align: PosAlign.left),
//     );

//     // Payment Info
//     bytes += generator.text(
//       'CASH SALE      \$12.97\nCash Tendered    \$20.00\nChange         \$7.03',
//       styles: const PosStyles(align: PosAlign.left),
//     );

//     bytes += generator.emptyLines(2);
//     bytes += generator.text(
//       'REPRINT',
//       styles: const PosStyles(align: PosAlign.center, bold: true),
//     );

//     // Footer Information
//     bytes += generator.emptyLines(1);
//     bytes += generator.text(
//       'Clover ID: KFCSY5VJQ0QEE',
//       styles: const PosStyles(align: PosAlign.center),
//     );

//     bytes += generator.text(
//       'Payment Y5HPK6TQRWR',
//       styles: const PosStyles(align: PosAlign.center),
//     );

//     bytes += generator.cut();

//     return bytes;
//   }

//   Future<void> printTicket(List<int> ticket, {String? ip, int? port}) async {
//     final printer = PrinterNetworkManager(ipController.text.trim(), port: 9100);
//     PosPrintResult connect = await printer.connect();
//     if (connect.msg.contains('Success')) {
//       print('connected successfully');
//     }
//     if (connect == PosPrintResult.success) {
//       PosPrintResult printing = await printer.printTicket(ticket);
//       printer.disconnect();
//     } else {
//       Fluttertoast.showToast(
//         msg: "Please check ThermalPrinterConnectivity Printer Connection.",
//         gravity: ToastGravity.CENTER,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Printer Connection")),
//       body: Column(
//         children: [
//           TextField(controller: ipController),
//           ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.resolveWith((states) {
//                 return Colors.green;
//               }),
//             ),
//             onPressed: () async {
//               var res = await connectionBuild();
//               print('connection status : ${res.toString()}');
//               await printTicket(res, ip: ipController.text.trim(), port: 9100);
//             },
//             child: Text('Print Receipt'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//? new
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/services.dart';
import 'package:image/src/image/image.dart';

import 'package:printer_integration_application/logo_image.dart';

import 'package:qr_flutter/qr_flutter.dart';

class ThermalPrinterConnectivity extends StatefulWidget {
  const ThermalPrinterConnectivity({super.key});

  @override
  State<ThermalPrinterConnectivity> createState() =>
      _ThermalPrinterConnectivityState();
}

class _ThermalPrinterConnectivityState
    extends State<ThermalPrinterConnectivity> {
  TextEditingController ipController = TextEditingController();

  // Function to build the receipt
  Future<List<int>> connectionBuild() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    final image = await genrateLogo();
    if (image == null) {
      print("if");
    } else {
      print("else");
      bytes += generator.image(image);
      bytes += generator.setStyles(PosStyles(align: PosAlign.center));
    }

    // Add logo at the top (if available)
    // final logoBytes = await loadLogo();
    // EscPosImage logoImage = await decodeImageFromList(logoBytes);

    // if (logoImage != null) {
    //   bytes += generator.image(logoImage);  // Print the logo image
    // }

    bytes += generator.emptyLines(1);

    // Store Name
    bytes += generator.text(
      'SULEMAN AHMAD',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size3,
        width: PosTextSize.size3,
      ),
    );

    bytes += generator.text(
      'MUMTAZ MARKET',
      styles: const PosStyles(
        align: PosAlign.center,
        // height: PosTextSize.size2,
        // width: PosTextSize.size2,
      ),
    );

    bytes += generator.text(
      'ERA TECH GUJRANWALA',
      styles: const PosStyles(
        align: PosAlign.center,
        // height: PosTextSize.size2,
        // width: PosTextSize.size2,
      ),
    );
    bytes += generator.text(
      'PAKISTAN',
      styles: const PosStyles(
        align: PosAlign.center,
        // height: PosTextSize.size2,
        // width: PosTextSize.size2,
      ),
    );

    bytes += generator.emptyLines(1);

    // Order Header
    bytes += generator.text(
      'ORDER: 0047\nTo Go Waiting\n',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.emptyLines(1);

    // // Items list (Item Name, Price, Refund/Exchange status)
    // List<Map<String, String>> items = [
    //   {'name': 'MANGO LASSI', 'price': '\$2.99', 'status': 'Refunded: -\$2.99'},
    //   {
    //     'name': 'CHICKEN BIRYANI',
    //     'price': '\$8.99',
    //     'status': 'Exchanged: \$8.99',
    //   },
    //   {
    //     'name': 'CHICKEN PULAO',
    //     'price': '\$8.99',
    //     'status': 'Refunded: -\$8.99',
    //   },
    // ];

    // for (var item in items) {
    //   // Print the item name on the left, price on the right
    //   bytes += generator.text(
    //     '${item['name']?.padRight(20)}${item['price']?.padLeft(10)}',
    //     styles: const PosStyles(align: PosAlign.left),
    //   );
    //   bytes += generator.text(
    //     '${item['status']?.padLeft(40)}',
    //     styles: const PosStyles(align: PosAlign.right),
    //   );
    // }

    // // Sales Tax and Total
    // bytes += generator.emptyLines(1);
    // bytes += generator.text(
    //   'Sales Tax: 8.25%   \$0.99',
    //   styles: const PosStyles(align: PosAlign.left),
    // );
    // bytes += generator.text(
    //   'Total: \$0.00',
    //   styles: const PosStyles(align: PosAlign.left),
    // );

    // // Payment Information
    // bytes += generator.emptyLines(1);
    // bytes += generator.text(
    //   'CASH SALE      \$12.97\nCash Tendered    \$20.00\nChange         \$7.03',
    //   styles: const PosStyles(align: PosAlign.left),
    // );

    bytes += generator.row([
      PosColumn(
        text: '1  Mango Lassi',
        width: 9,

        styles: PosStyles(align: PosAlign.left, underline: false),
      ),
      // PosColumn(
      //   // text: 'col6',
      //   width: 6,
      //   styles: PosStyles(align: PosAlign.center, underline: true),
      // ),
      PosColumn(
        text: '\$ 2.99',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);

    bytes += generator.text(
      'Refunded - \$ 2.99',
      styles: const PosStyles(align: PosAlign.right),
    );
    bytes += generator.emptyLines(1);

    bytes += generator.row([
      PosColumn(
        text: '1  Chicken Biryani',
        width: 9,
        styles: PosStyles(align: PosAlign.left, underline: false),
      ),
      // PosColumn(
      //   // text: 'col6',
      //   width: 6,
      //   styles: PosStyles(align: PosAlign.center, underline: true),
      // ),
      PosColumn(
        text: '\$ 8.99',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);

    bytes += generator.text(
      'Exchanged - \$ 8.99',
      styles: const PosStyles(align: PosAlign.right),
    );
    bytes += generator.emptyLines(1);

    bytes += generator.row([
      PosColumn(
        text: '1  Chicken Pulao',
        width: 9,
        styles: PosStyles(align: PosAlign.left, underline: false),
      ),
      // PosColumn(
      //   // text: 'col6',
      //   width: 6,
      //   styles: PosStyles(align: PosAlign.center, underline: true),
      // ),
      PosColumn(
        text: '\$ 8.99',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);

    bytes += generator.text(
      'Refunded - \$ 8.99',
      styles: const PosStyles(align: PosAlign.right),
    );

    bytes += generator.emptyLines(2);

    bytes += generator.row([
      PosColumn(
        text: 'Sales Tax',
        width: 4,
        styles: PosStyles(align: PosAlign.left, underline: false),
      ),
      PosColumn(
        text: '8.25%',
        width: 4,
        styles: PosStyles(align: PosAlign.center, underline: false),
      ),
      PosColumn(
        text: '\$ 0.99',
        width: 4,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);

    bytes += generator.emptyLines(1);

    bytes += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: PosStyles(
          align: PosAlign.left,
          underline: false,
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
      ),

      PosColumn(
        text: '\$ 0.00',
        width: 6,
        styles: PosStyles(
          align: PosAlign.right,
          underline: false,
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
      ),
    ]);
    bytes += generator.emptyLines(1);
    bytes += generator.row([
      PosColumn(
        text: 'CASH SALE',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: false, bold: true),
      ),

      PosColumn(
        text: '\$ 12.97',
        width: 6,
        styles: PosStyles(align: PosAlign.right, underline: false, bold: false),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'CASH Tendered',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: false, bold: true),
      ),

      PosColumn(
        text: '\$ 20.00',
        width: 6,
        styles: PosStyles(align: PosAlign.right, underline: false, bold: false),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'CHANGE',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: false, bold: true),
      ),

      PosColumn(
        text: '\$ 7.03',
        width: 6,
        styles: PosStyles(align: PosAlign.right, underline: false, bold: false),
      ),
    ]);
    bytes += generator.emptyLines(1);

    // Print straight barcode
    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.text(
      'Thank You for visiting us!.....',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size1,
      ),
    );

    bytes += generator.qrcode('example.com', size: QRSize.size8);

    // bytes += generator.emptyLines(1);
    // bytes += generator.text(
    //   'Clover ID: KFCSY5VJQ0QEE',
    //   styles: const PosStyles(align: PosAlign.center),
    // );

    // bytes += generator.text(
    //   'Payment Y5HPK6TQRWR',
    //   styles: const PosStyles(align: PosAlign.center),
    // );

    bytes += generator.cut();

    return bytes;
  }

  // Function to print the receipt
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
        msg: "Please check ThermalPrinterConnectivity Printer Connection.",
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
                return Colors.green;
              }),
            ),
            onPressed: () async {
              var res = await connectionBuild();
              print('connection status : ${res.toString()}');
              await printTicket(res, ip: ipController.text.trim(), port: 9100);
            },
            child: Text('Print Receipt'),
          ),
        ],
      ),
    );
  }
}
