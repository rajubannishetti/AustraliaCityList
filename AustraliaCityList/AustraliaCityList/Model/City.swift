//
//  City.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import Foundation

struct City: Identifiable, Codable, Hashable {
    
    var city, lat, lng: String
    var country: String
    var iso2: String
    var admin_name: String
    var capital: String
    var id: String { "population_proper" }
    var population: String
    
}
