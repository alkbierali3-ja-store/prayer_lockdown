import 'package:flutter/material.dart';
import 'async';

void main() {
  runApp(const PrayerApp());
}

class PrayerApp extends StatelessWidget {
  const PrayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خلوة الصلاة',
      theme: ThemeData(fontFamily: 'sans-serif'),
      // نحدد الصلاة التجريبية هنا (يمكنك تغييرها لـ Dhuhr أو Asr أو Maghrib أو Isha)
      home: const PrayerLockScreen(prayerName: 'Fajr'),
    );
  }
}

class PrayerLockScreen extends StatefulWidget {
  final String prayerName;

  const PrayerLockScreen({Key? key, required this.prayerName}) : super(key: key);

  @override
  _PrayerLockScreenState createState() => _PrayerLockScreenState();
}

class _PrayerLockScreenState extends State<PrayerLockScreen> {
  int _secondsRemaining = 600; // 10 دقائق
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Map<String, dynamic> _getPrayerData() {
    switch (widget.prayerName) {
      case 'Fajr':
        return {
          'title': 'الصلاة خير من النوم',
          'subtitle': 'أطفئ شاشتك، واستيقظ لتنور يومك.. فجر جديد وفرصة جديدة.',
          'bgColor': const Color(0xFF0F172A),
          'accentColor': const Color(0xFF38BDF8),
        };
      case 'Dhuhr':
        return {
          'title': 'أرحنا بها يا بلال',
          'subtitle': 'خذ استراحة من صخب الدنيا، واشحن روحك لخمس دقائق.',
          'bgColor': const Color(0xFF0284C7),
          'accentColor': const Color(0xFFBAE6FD),
        };
      case 'Asr':
        return {
          'title': 'حَافِظُوا عَلَى الصَّلَوَاتِ وَالصَّلَاةِ الْوُسْطَى',
          'subtitle': 'بقي القليل على انتهاء يومك، لا تدع التعب يسرق منك أجر العصر.',
          'bgColor': const Color(0xFFC2410C),
          'accentColor': const Color(0xFFFED7AA),
        };
      case 'Maghrib':
        return {
          'title': 'أقبل على مائدة السماء',
          'subtitle': 'اختم نهارك بالحمد والثناء قبل أن تبدأ ليلتك.',
          'bgColor': const Color(0xFF831843),
          'accentColor': const Color(0xFFFBCFE8),
        };
      case 'Isha':
      default:
        return {
          'title': 'استرح من عناء اليوم بين يدي ربك',
          'subtitle': 'اجعل آخر ما تفعله في يومك صلاة وذكراً، لتنام بسكينة.',
          'bgColor': const Color(0xFF1E1B4B),
          'accentColor': const Color(0xFFC7D2FE),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _getPrayerData();
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: data['bgColor'],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_filled, size: 80, color: data['accentColor']),
              const SizedBox(height: 20),
              Text(
                data['title'],
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                data['subtitle'],
                style: const TextStyle(fontSize: 14, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                "$minutes:$seconds",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: data['accentColor']),
              ),
              const SizedBox(height: 50),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone, color: Colors.white),
                label: const Text("مكالمة طارئة", style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white38),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
