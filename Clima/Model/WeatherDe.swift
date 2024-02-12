import Foundation

struct datafetch:Codable{
    let name:String
    let main:main
    let weather:[weather]
}

struct weather:Codable{

    let description:String
    let id:Int
}
struct main:Codable{
    let temp:Double
}
