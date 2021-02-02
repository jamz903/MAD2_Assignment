//
//  BusService.swift
//  Assignment_Draft
//
//  Created by Justin Ng on 14/1/21.
//

import Foundation

struct BusService: Codable {
    public var BusStopCode: String
    public var Services: [Service]
}

struct Service: Codable {
    public var ServiceNo: String
    public var Operator: String
    public var NextBus: NextBus
    public var NextBus2: NextBus2
    public var NextBus3: NextBus3
}

struct NextBus: Codable {
    public var OriginCode: String
    public var DestinationCode: String
    public var EstimatedArrival: String
    public var Latitude: String
    public var Longitude: String
    public var VisitNumber: String
    public var Load: String
    public var Feature: String
    public var `Type`: String
}

struct NextBus2: Codable {
    public var OriginCode: String
    public var DestinationCode: String
    public var EstimatedArrival: String
    public var Latitude: String
    public var Longitude: String
    public var VisitNumber: String
    public var Load: String
    public var Feature: String
    public var `Type`: String
}

struct NextBus3: Codable {
    public var OriginCode: String
    public var DestinationCode: String
    public var EstimatedArrival: String
    public var Latitude: String
    public var Longitude: String
    public var VisitNumber: String
    public var Load: String
    public var Feature: String
    public var `Type`: String
    
}
