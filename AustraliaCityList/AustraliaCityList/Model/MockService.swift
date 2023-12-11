//
//  MockService.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import Foundation

enum MockService {
    
    static func loadData(file: String) -> [City] {
        return Bundle.main.decode([City].self, from: file)
    }
    
}
