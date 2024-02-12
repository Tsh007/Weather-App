import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet var searchTextField: UITextField!
    let locationManager=CLLocationManager()
    
    
    @IBAction func currentLocationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    
    var weatherManager=WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        searchTextField.delegate=self
        weatherManager.delegate=self
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController:UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
//        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(textField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder="Enter some place"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        weatherManager.cityURL(city: textField.text)
        
        if let city=textField.text{
//            print(city)
            weatherManager.fetchWeather(city: city)
        }
        searchTextField.text=""
    }
    
}


//MARK: - WeatherManagerDelegate

extension WeatherViewController:WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager:WeatherManager,weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.tempString
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.name
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


extension WeatherViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations)
            if let location = locations.last {
//                print("Location data received.")
                locationManager.stopUpdatingLocation()
                let long=location.coordinate.longitude
                let lat=location.coordinate.latitude
                weatherManager.fetchWeather2(lat: lat, long: long)
//                print(long)
//                print(lat)
//                print(location)
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get users location.")
            print(error)
        }
}
