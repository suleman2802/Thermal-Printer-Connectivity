import 'dart:typed_data' show ByteData, Uint8List;
import 'package:intl/intl.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';



import 'package:image/image.dart' as Img;

class ThermalPrinterServices {


  Future<void> printTicket(List<int> ticket, String ip,{ int? port}) async {
    final printer = PrinterNetworkManager(ip, port: 9100);
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


    // Function to build the receipt
  Future<List<int>> PrepareKdsReceipt() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
      'Rafia',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );
    bytes += generator.text(
      'ORDER: 0041',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );

    bytes += generator.text(
      'TO GO PHONE ORDER',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );

    bytes += generator.emptyLines(1);

    // Print date and time
    bytes += generator.text(
      'Date: ${DateFormat('yyyy-MM-dd h:mm:ss a').format(DateTime.now()).toString()}',
      styles: const PosStyles(align: PosAlign.left),
    );

    // bytes += generator.text(
    //   'Printed: ${DateFormat('yyyy-MM-dd h:mm:ss a').format(DateTime.now()).toString()}',
    //   styles: const PosStyles(align: PosAlign.left),
    // );

    bytes += generator.text(
      "Order Note : Don't make any thing spicy",
      styles: const PosStyles(align: PosAlign.left),
    );

    bytes += generator.emptyLines(1);

    // Items list

    bytes += generator.text(
      "2 CHK CHARGA (don't over cooked it serve with lemon garnishing)",
      styles: const PosStyles(align: PosAlign.left),
    );

    bytes += generator.text(
      "1 Chk Biryani",
      styles: const PosStyles(align: PosAlign.left),
    );

    bytes += generator.text(
      '  - without Potatoes',
      styles: const PosStyles(align: PosAlign.right),
    );

    bytes += generator.emptyLines(1);

    // Customer Info
    bytes += generator.text(
      'Customer Info:',
      styles: const PosStyles(align: PosAlign.left),
    );
    bytes += generator.text(
      'Name: Rafia',
      styles: const PosStyles(align: PosAlign.left),
    );
    bytes += generator.text(
      'Phone: 3466297214',
      styles: const PosStyles(align: PosAlign.left),
    );
    // bytes += generator.text('ID: VQ2KBTKWAGMNE', styles: const PosStyles(align: PosAlign.left));

    bytes += generator.emptyLines(1);

    bytes += generator.cut();

    return bytes;
  }

    // Function to build the receipt
  Future<List<int>> prepareSaleReceipt() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    // final Image? image = await genrateLogo();
    // if (image == null) {
    //   print("if");
    // } else {
    //   print("else");
    //   bytes += generator.image(image);
    //   bytes += generator.setStyles(PosStyles(align: PosAlign.center));
    // }
    final ByteData data = await rootBundle.load('assets/image/logo1.jpg');

    final Uint8List byte = data.buffer.asUint8List();

    final Img.Image image = Img.decodeImage(byte)!;
    // Using `ESC *`
    bytes += generator.image(image);
    // Using `GS v 0` (obsolete)
    //! bytes+=  generator.imageRaster(image);
    // Using `GS ( L`
    //! bytes+= generator.imageRaster(image, imageFn: PosImageFn.graphics);
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

    bytes += generator.text(
      'Cashier : Amar Kahsif',
      styles: const PosStyles(
        align: PosAlign.left,
        // height: PosTextSize.size2,
        // width: PosTextSize.size2,
      ),
    );
    bytes += generator.text(
      'Date : ${DateFormat('dd-MM-yyy hh:mm:ss a').format(DateTime.now()).toString()}',
      styles: const PosStyles(
        align: PosAlign.left,
        // height: PosTextSize.size2,
        // width: PosTextSize.size2,
      ),
    );
    bytes += generator.emptyLines(1);
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
        text: '\$ 2.99 ',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);
    bytes += generator.text(
      '+ 1x without sugar  \$ 0.00 ',
      styles: const PosStyles(align: PosAlign.right),
    );
    bytes += generator.text(
      '+ 3x Ice-Creem Scoop  \$ 2.90 ',
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
        text: '\$ 8.99 ',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);

    bytes += generator.text(
      'Exchanged - \$ 8.99 ',
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
        text: '\$ 8.99 ',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: false),
      ),
    ]);

    bytes += generator.text(
      'Refunded - \$ 8.99 ',
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
        text: '\$ 0.99 ',
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
        text: '\$ 0.00 ',
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
        text: '\$ 12.97 ',
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
        text: '\$ 20.00 ',
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
        text: '\$ 7.03 ',
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

    bytes += generator.emptyLines(1);

    bytes += generator.qrcode('example.com', size: QRSize.size8);

    bytes += generator.cut();

    return bytes;
  }

    Future<List<int>> prepareConnectionBuildFReceipt() async {
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
      'Printer successfully connected.',
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.emptyLines(2);
    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }



}
