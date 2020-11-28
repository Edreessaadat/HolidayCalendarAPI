//
//  HolidayRequeste.swift
//  HolidayCalendarAPI
//
//  Created by Mohammad Edrees on 11/26/20.
//

import Foundation

// for the error in case happen there is no data or data not process due to some reasons.
enum HolidaysError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidaysRequest {
    let resourceURL:URL
    let API_KEY = "a229ee13656f3fd3d6443072c5b951e507fb8d0c"
    
    init(countryCode:String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
            guard let resourceURL = URL(string: resourceString) else {
                fatalError()
                
            }
        
        self.resourceURL = resourceURL
    
  }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidaysError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidaysDetail = holidaysResponse.response.holidays
                completion(.success(holidaysDetail))
                
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
}
