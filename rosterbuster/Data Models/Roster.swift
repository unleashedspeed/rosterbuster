//
//  Roster.swift
//  rosterbuster
//
//  Created by Saurabh Gupta on 08/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation

struct Roster : Codable {
    
    let flightnr: String?
    let date: String?
    let aircraftType: String?
    let tail: String?
    let departure: String?
    let destination: String?
    let departTime: String?
    let arrivalTime: String?
    let dutyID: String?
    let dutyCode: String?
    let captain: String?
    let firstOfficer: String?
    let flightAttendant: String?
    
    enum CodingKeys: String, CodingKey {
        case flightnr = "Flightnr"
        case date = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case departTime = "Time_Depart"
        case arrivalTime = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
    }
    
}


