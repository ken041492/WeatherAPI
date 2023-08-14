//
//  WeatherResponse.swift
//  Weather API
//
//  Created by imac-1682 on 2023/8/10.
//

import Foundation

struct WeatherResponse: Codable {
    var success: String
    var result: ResultValue
    var records: Records
}

struct ResultValue: Codable {
    var resource_id: String
    var fields: [Fields]
}

struct Fields: Codable {
    var id: String
    var type: String
}

struct Records: Codable {
    var datasetDescription: String
    var location: [Location]
}

struct Location: Codable {
    var locationName: String
    var weatherElement: [WeatherElement]
}

struct WeatherElement: Codable {
    var elementName: String
    var time: [Time]
}

struct Time: Codable {
    var startTime: String
    var endTime: String
    var parameter: Parameter
}

struct Parameter: Codable {
    var parameterName: String
    var parameterValue: String?
    var parameterUnit: String?
}
