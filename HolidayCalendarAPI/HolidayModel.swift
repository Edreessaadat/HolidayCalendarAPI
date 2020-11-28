//
//  HolidayModel.swift
//  HolidayCalendarAPI
//
//  Created by Mohammad Edrees on 11/26/20.
//

import Foundation

struct HolidayResponse: Decodable {
    var response:Holiday
}

struct Holiday:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
}
struct DateInfo:Decodable {
    var iso:String
}
