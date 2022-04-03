//
//  WeatherManager.swift
//  Weather
//
//  Created by Aries Lam on 4/1/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(_ error: Error)
    
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2846316988260be1237a5fdbcf385d64&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(_ cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let urlWithLonLat = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(urlString: urlWithLonLat)
    }
    
    func performRequest(urlString: String){
        
        // create URL
        if let url = URL(string: urlString){
            
            //create a URLSession
            print(url)
            let session = URLSession(configuration: .default) //create a session object which is like a browser, can perform the networking
            
            //give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            delegate?.didFailWithError(error!)
            return
        }
        if let safeData = data{
            if let weather = parseJSON(weatherData: safeData){
                delegate?.didUpdateWeather(weather: weather)
            }
           
        }
        
    }
    
    func parseJSON(weatherData: Data)-> WeatherModel?{
        do{
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperture: temp)
            return weather
            
        } catch{
            delegate?.didFailWithError(error)
        }
        return nil
        
    }
    
    
}

