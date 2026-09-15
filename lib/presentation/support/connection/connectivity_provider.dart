import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();

      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        return true;
      }
      return true;
    } catch (e) {
      print('Xatolik: $e');
      return true;
    }
  }

  Stream<bool> get connectionStream {
    return _connectivity.onConnectivityChanged.map((results) {
      return results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);
    });
  }
}

// Ishlatish misoli
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
    _listenToConnectionChanges();
  }

  // Dastlabki ulanishni tekshirish
  Future<void> _checkInitialConnection() async {
    final isConnected = await _connectivityService.hasInternetConnection();
    setState(() {
      _isConnected = isConnected;
    });

    if (!isConnected) {
      _showNoInternetAlert();
    }
  }

  // Ulanish o'zgarishlarini tinglash
  void _listenToConnectionChanges() {
    _connectivityService.connectionStream.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });

      if (!isConnected) {
        _showNoInternetAlert();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Internet ulanishi tiklandi'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  // Internet yo'q haqida alert ko'rsatish
  void _showNoInternetAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.red),
            SizedBox(width: 10),
            Text('Internet yo\'q'),
          ],
        ),
        content: const Text(
          'Internet ulanishi mavjud emas. Iltimos, internet ulanishingizni tekshiring.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final isConnected = await _connectivityService.hasInternetConnection();
              if (!isConnected) {
                _showNoInternetAlert();
              }
            },
            child: const Text('Qayta tekshirish'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yopish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Tekshirish'),
        backgroundColor: _isConnected ? Colors.blue : Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isConnected ? Icons.wifi : Icons.wifi_off,
              size: 100,
              color: _isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              _isConnected
                  ? 'Internet ulanishi mavjud'
                  : 'Internet ulanishi yo\'q',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final isConnected = await _connectivityService.hasInternetConnection();
                if (!isConnected) {
                  _showNoInternetAlert();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Internet ulanishi mavjud!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Ulanishni tekshirish'),
            ),
          ],
        ),
      ),
    );
  }
}