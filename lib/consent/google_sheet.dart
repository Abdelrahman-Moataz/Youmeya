import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsheets/gsheets.dart';
import '../controllers/home_controller.dart';
import 'consent.dart';
import 'google_sheet_column.dart';

class sheetsFlutter {
  static String _sheetId = "12VvDE6_FIjxq2T8x4P3w_u7JjRUQVWXbFKNoHcp-hX8";

  static const _sheetCredentials = r'''
{
  "type": "service_account",
  "project_id": "youmeya-478a9",
  "private_key_id": "ea633ab0ccdbf9883da4f5a845ff535963ec2c62",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrQBwbvTFhoDF6\net8BVQgg9ox9mXlWqFrJP3bbe43AXFfGDDeNHKxIK/iYOCkCmxRrayS0wozkO8jp\nl6u9akKuuPBGc40SbCY63m2LLBPYPNZE5fzVFb/QDnxgina09KII3LrVhKZdsbj7\nXhPRCi3LqT7UJpnXRqgZZjrsVzqLLbQlYMGUDko1PrpGWt4UWqS2NUbqXOHVCRgI\nKKXj7ipYpZOyzP0a8vR6ixHhaR1eiges0US8si0ROiFpjPsh/7qdwcJFyIm0+nN2\nMCf84nTpTXOnX7NOGYe1/XIAvziH3Uw8FpaFvyLJmBiszdoOSQobLTtLemRLJtPf\nd8+JKx3bAgMBAAECggEABYcB0nsTV/VoPoGROsyfvAFAl8Ov/onR8n4GclCBcjyN\ntVQNT+Lqf2eysZLGeVG/8EiTQ7lq6CSB2sU5eU9qyeIBew+69WXNnce8Rxt1y0i6\nyq6p/rNTFsM4UUR4E+9MN5TbXlKbhZmW1Ku8wp7nQYBtCWpBipyTJEMJ62CjO30L\nLa5xm5K3q2sWb2cLZ4Bcc8lXS4yOgHNwxvLTm/CDRAMaweOruyuCU8v7hgtX0PJt\nZ+fIspZFCrkaDL/TQ6+Dsyme22i38i34HT9XLVd4Ky/jylRyoH7VTwUUr0s6hfU9\nqrri2ChuOyjxFGHuQT0Tt+fkZ36+uF14+rXd9uLBOQKBgQDUOBjYHloqe4KlRB9o\nacgPhjvU3bFLbY/cAp/+tK9+cFXo2NAbnBbKcV4/Zuey9XYOiuYFn8LeW5b55Nc6\nRj4gIy5p9fsj+WrOy8MINejwerT9WbBHficzHcLh1RAqffNgeyS9B/o0zWyErWhQ\nqMPKrwxCegx13e+TA0kQjgY+pwKBgQDOlFZ5Yarn+Tn4+98pUZpTEpTkz5JheEi5\nLVLewyEDx+NhTGec4r1fo8bKDz/F7J5jvbU3UpuMhATwr21tPpWBKxcSLiKLhczT\nk+Ewc5+jXyAhlGYWMOeLwI5+2NTAki0uLhPQuczoQ0OYauj0i9XOtLSoDJUDo4gZ\n7w/ljU7hrQKBgG5SHzAyTyMog9kQGde4reTMHkxhVupkMVXpE21gVp6/HRnno//G\nW96vopQJFcflbJLQyBUCYVYgfNK5kN1daKxiPZ2d3wlrfoe0S1X4WHizAWV2+3me\n7hfXj9jAXyAHy75LJeUSwZIzfAdY8hKEOQwjhZcFRXb8ga+GFLSDcGGfAoGBAJhr\nhJ5MvNAp6GdYV+Dhr88pf6iPqv61xFq1IVbxfFOQ0alBuZVdCsMdURhXRgOgQYFw\nQNwP3GtCIW8A0Olw6tiCVaR5W828LFPT4axhM2FUV53PI7+t17oamkjnbZqkgCd5\noe84mAKrVp2IDFgbMOcyF7WCixRDPbF83SrPJ2uFAoGAXCYNIFU1Z06L/qVh4xcI\nCt+PSmwpRcseYykezxYYklAgzIa+TEIjxWMY5Hdv/ltRd1ry66DkkOftpo9QaDsP\nLkfMQPTCWwCw3PNMu5djO5ivb1lzAY/uaC0WkxzqPUaTQOzIJSDohtSSzcrsnoaR\nrtW67pQDvUA7sxSfafDLQOY=\n-----END PRIVATE KEY-----\n",
  "client_email": "youmeya@youmeya-478a9.iam.gserviceaccount.com",
  "client_id": "116699962435138207434",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/youmeya%40youmeya-478a9.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init({time, date}) async {
    try {
      final spreadSheet = await _gsheets.spreadsheet(_sheetId);
      _userSheet = await _getWorksheet(spreadSheet, title: "title");

      // Get data from Firestore collection and insert into the Google Sheet
      final ordersSnapshot =
      await FirebaseFirestore.instance.collection(cartCollection).get();
      final rows = ordersSnapshot.docs.map((doc) {
        final orderId = doc.id;
        final orderData = doc.data() as Map<String, dynamic>;
        return {
          'orderId': orderId,
          'time': "time",
          'date': "date",
          ...orderData
        };
      }).toList();

      await insert(rows);
    } catch (e) {
      print(e);
    }
  }

  static Future<Worksheet?> _getWorksheet(
      Spreadsheet spreadsheet, {
        required title,
      }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}