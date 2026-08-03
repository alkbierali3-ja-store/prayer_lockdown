import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PrayerService {
  // 1. جلب مواقيت الصلاة باستخدام إحداثيات الـ GPS والـ API
  static Future<Map<String, String>?> fetchAndSavePrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      'https://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude&method=5',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];

        Map<String, String> prayerTimes = {
          'Fajr': timings['Fajr'],
          'Dhuhr': timings['Dhuhr'],
          'Asr': timings['Asr'],
          'Maghrib': timings['Maghrib'],
          'Isha': timings['Isha'],
        };

        // حفظ المواقيت محلياً للعمل بدون إنترنت (Offline Cache)
        await savePrayerTimesLocally(prayerTimes);

        return prayerTimes;
      }
    } catch (e) {
      print("تعذر الاتصال بالشبكة، جاري التحميل من التخزين المحلي: $e");
    }

    // في حال عدم وجود إنترنت، يتم الجلب من التخزين المحلي تلقائياً
    return await getLocalPrayerTimes();
  }

  // 2. حفظ المواقيت على ذاكرة الهاتف الداخلية
  static Future<void> savePrayerTimesLocally(Map<String, String> times) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(times);
    await prefs.setString('offline_prayer_times', encodedData);
  }

  // 3. قراءة المواقيت المحفوظة محلياً عند عدم توفر الإنترنت
  static Future<Map<String, String>?> getLocalPrayerTimes() async {
    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString('offline_prayer_times');

    if (localData != null) {
      Map<String, dynamic> decoded = json.decode(localData);
      return decoded.map((key, value) => MapEntry(key, value.toString()));
    }
    return null;
  }
}
