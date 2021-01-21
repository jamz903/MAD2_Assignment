//
//  BusStops.swift
//  MAD2_Assignment
//
//  Created by Justin Ng on 17/1/21.
//

import Foundation

struct BusStops: Codable {
    public var value: [BusStop]
}

struct BusStop: Codable {
    public var BusStopCode: String
    public var RoadName: String
    public var Description: String
    public var Latitude: Double
    public var Longitude: Double
}
