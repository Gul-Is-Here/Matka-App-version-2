import 'package:flutter/material.dart';

DataRow buildSourceRow(
    Map<String, dynamic> source, double versionWidth, double installWidth) {
  return DataRow(
    cells: [
      DataCell(Container(width: 40, child: Text(source['id'].toString()))),
      DataCell(Container(width: versionWidth, child: Text(source['version']))),
      DataCell(
          Container(width: installWidth, child: Text(source['totalInstall']))),
      DataCell(Container(
          width: installWidth, child: Text(source['currentInstall']))),
    ],
  );
}