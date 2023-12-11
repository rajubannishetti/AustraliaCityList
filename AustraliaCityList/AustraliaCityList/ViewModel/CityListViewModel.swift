//
//  CityListViewModel.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import Foundation

class CityListViewModel: ObservableObject {
    @Published var city: [City] = []
    @Published var grouping: Grouping = .admin_name
    var isExpanded: Bool = false
    
    init(forPreview: Bool = true) {
        if forPreview {
            city = MockService.loadData(file: FileConstant.fileName)
        }
    }
}

extension CityListViewModel {
    
    enum Grouping: String, CaseIterable, Identifiable {
        var id: String {
            self.rawValue
        }
        case admin_name
    }
    
    var groupingData: [String: [City]] {
        switch grouping {
        case .admin_name:
            return Dictionary(grouping: city) { $0.admin_name }
        }
    }
    
    var sectionHeaders: [String] {
        switch grouping {
        case .admin_name:
            return Array(Set(city.map {$0.admin_name})).sorted(by: <)
        }
    }
    
    func sectionHeader(_ Key: String) -> String {
        switch grouping {
        case .admin_name:
            return Key
        }
    }
    
    func sectionContent(_ key: String) -> [City] {
        let content = groupingData[key] ?? []
        return content.sorted(by: {($0.admin_name) < ($1.admin_name) })
    }
    
}
