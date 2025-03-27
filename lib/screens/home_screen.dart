import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('天気予報アプリ')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: '都市名を入力',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('天気を取得'),
              onPressed: () {
                weatherProvider.getWeather(_cityController.text);
              },
            ),
            SizedBox(height: 20),
            weatherProvider.isLoading
                ? CircularProgressIndicator()
                : weatherProvider.weather != null
                    ? Column(
                        children: [
                          Text(
                            '${weatherProvider.weather!.cityName}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            '${weatherProvider.weather!.temperature}°C',
                            style: TextStyle(fontSize: 48),
                          ),
                          Text(
                            '${weatherProvider.weather!.description}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Image.network(
                            'https://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png',
                          ),
                        ],
                      )
                    : Text('天気情報がありません'),
          ],
        ),
      ),
    );
  }
}
