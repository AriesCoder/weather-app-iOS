//
//  ViewController.swift
//  Weather
//
//  Created by Aries Lam on 4/1/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchBar.delegate = self
   
    }

    
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        //dismiss keyboard
        searchBar.endEditing(true)
        print(searchBar.text!)
        
    }
    
    
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         
         if let city = searchBar.text{
             let cityNameWithoutSpace = city.replacingOccurrences(of: " ", with: "+")
             weatherManager.fetchWeather(cityNameWithoutSpace)
         }else{return}
         
         //clear the searchbar after search
         searchBar.text = ""
     }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //dismiss keyboard
        searchBar.endEditing(true)
        print(searchBar.text!)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
       //remind user to type in searchbar, action doesnt happen if searchbar is empty
        if searchBar.text != ""{
            return true
        }else{
            searchBar.placeholder = "should type a city name"
            return false
        }
    }
    
}

//MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weather.temperture)
            self.cityLabel.text = weather.cityName
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
        }
        
        
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate{
    @IBAction func navigateButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longtitude: lon)
                
        }
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
