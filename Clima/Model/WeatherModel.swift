import Foundation

struct WeatherModel{
    
    let name:String
    let id:Int
    let temp:Double
    
    var tempString:String{
        return String(format: "%.1f",temp)
    }
    
    var conditionName:String{
        switch id{
        case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }
    
//    func getConditionName(weatherId:Int)->String{
//        
//    }
    //instead of this we used the computed property 
    
}
