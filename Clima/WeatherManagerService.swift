import UIKit

protocol WeatherManagerDelegate: UIViewController {
    func didUpdateWeather(_ weatherManager:WeatherManagerService, weather: WeatherModel)
    func didFailWithError(error: Error)
}


class WeatherManagerService {
    
    var delegate : WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=ae23ae517aeb7c88cf8b3e5cc588521b&units=metric"
    
    func fetchWeatherData  (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
       
        self.makeWeatherGetCall(with: urlString)
    }
    
    func fetchWeatherDataByCoordinates(_ lat: Double, _ lon: Double){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        print(urlString)
        self.makeWeatherGetCall(with: urlString)
    }
    
    func makeWeatherGetCall(with urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, urlReponse, error in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }

                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = result.main.temp
            let id = result.weather[0].id
            let city = result.name
            let description = result.weather[0].description
            let weather = WeatherModel(city: city, temp: temp, description: description, conditionId: id)
            return weather
            
        }
        catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
  
    
}
