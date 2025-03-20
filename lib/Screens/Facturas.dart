import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FacturacionPage extends StatelessWidget {
  final List<Map<String, dynamic>> materialesSeleccionados;

  FacturacionPage({required this.materialesSeleccionados});

  double get subtotal {
    return materialesSeleccionados.fold(
      0.0,
      (sum, item) => sum + (item['cantidad'] * item['precio']),
    );
  }

  double get itbis {
    return subtotal * 0.18;
  }

  double get totalFinal {
    return subtotal + itbis;
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Text('Factura', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Trabajo', 'Material', 'Cantidad', 'Precio', 'Subtotal'],
              data: materialesSeleccionados.map((m) => [
                m['trabajo'],
                m['material'],
                m['cantidad'].toString(),
                '\$${m['precio'].toStringAsFixed(2)}',
                '\$${(m['cantidad'] * m['precio']).toStringAsFixed(2)}',
              ]).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Subtotal: \$${subtotal.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18)),
            pw.Text('ITBIS: \$${itbis.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Total: \$${totalFinal.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18)),
          ];
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lista de Materiales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: materialesSeleccionados.length,
              itemBuilder: (context, index) {
                final material = materialesSeleccionados[index];
                return ListTile(
                  title: Text("${material['trabajo']} - ${material['material']}"),
                  subtitle: Text(
                      "Cant: ${material['cantidad']} - Precio: \$${material['precio'].toStringAsFixed(2)} - Subtotal: \$${ (material['cantidad'] * material['precio']).toStringAsFixed(2) }"),
                );
              },
            ),
          ),
          Text("Subtotal: \$${subtotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("ITBIS: \$${itbis.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("Total: \$${totalFinal.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => _generatePDF(context),
            child: Text("Generar PDF"),
          ),
        ],
      ),
    );
  }
}
