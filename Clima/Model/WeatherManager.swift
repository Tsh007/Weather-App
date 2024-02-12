import Foundation

    protocol WeatherManagerDelegate{
        func didUpdateWeather(_ weatherManager:WeatherManager,weather:WeatherModel)
        func didFailWithError(error:Error)
    }

struct WeatherManager{
    
    let apiKey=key()
    var URL="https://api.openweathermap.org/data/2.5/weather?appid="
    
    var delegate:WeatherManagerDelegate?
    
    //    let city:String?
    func fetchWeather(city:String){
        let newURL=URL+apiKey.apiID+"&q=\(city)"+"&units=metric"
        performRequest(urlString: newURL)
    }
    
    func fetchWeather2(lat:Double,long:Double){
        let newURL=URL+"&lat=\(lat)&lon=\(long)"
        performRequest(urlString: newURL)
    }
    
    func performRequest(urlString:String){
        //1.Create a URL
        
        
        if let url=Foundation.URL(string:urlString){
            //2.create a URL session
            let session = URLSession(configuration: .default)
            //3. give URL session a task
            let task=session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //4.start task
            task.resume()
        }
    }
    
    //can use closure instead of the below function but for now i would like to stay on this 
    func handle(data:Data?,response:URLResponse?,error:Error?){
        if error != nil{
//            print(error!)
            delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safeData=data{
//            let dataString=String(data:safeData,encoding: .utf8)
//            print(dataString!)
            if let weather=parseJSON(safeData){
                delegate?.didUpdateWeather(self,weather:weather)//understand properly naming confusion
            }
        }
        
    }
    
    func parseJSON(_ data:Data)->WeatherModel?{
        let decoder=JSONDecoder()
        do{
            let decodedData=try decoder.decode(datafetch.self, from: data)
            let id=decodedData.weather[0].id
            let name=decodedData.name
            let temp=decodedData.main.temp
            
            
            let weatherModel=WeatherModel(name: name, id: id, temp: temp)
            return weatherModel
//            print(weatherModel.getConditionName(weatherId :id))
            //instead of using the above function we created a computed property to do the same
//            print(weatherModel.conditionName)
//            print(weatherModel.tempString)
        }
        catch{
//            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
