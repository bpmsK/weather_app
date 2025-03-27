import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFFDF6F0), // パステルピンクベージュ
      appBar: AppBar(
        title: Text('☁ 天気予報アプリ'),
        backgroundColor: Color(0xFFFAE3E3),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: '都市名を入力',
                labelStyle: TextStyle(color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                weatherProvider.getWeather(_cityController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC4D6), // かわいいピンク
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
              child: Text(
                '天気を取得する',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            weatherProvider.isLoading
                ? CircularProgressIndicator(
                    color: Color(0xFFFF9AA2),
                  )
                : weatherProvider.weather != null
                    ? Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Text(
                                '${weatherProvider.weather!.cityName}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${weatherProvider.weather!.temperature}°C',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '${weatherProvider.weather!.description}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 10),
                              Image.network(
                                'https://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png',
                                scale: 1.0,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Text(
                        '天気情報がありません',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
