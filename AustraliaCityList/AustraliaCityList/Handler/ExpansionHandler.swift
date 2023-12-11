//
//  ExpansionHandler.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import Foundation
import SwiftUI

enum ExpandableSection: Equatable {
    case section
}

class ExpansionHandler<T: Equatable>: ObservableObject {
    @Published private (set) var expandedItem: T?
    
    func isExpanded(_ item: T) -> Binding<Bool> {
        return Binding(
            get: { item == self.expandedItem },
            set: { self.expandedItem = $0 == true ? item : nil }
        )
    }
    
    func toggleExpanded(for item: T) {
        self.expandedItem = self.expandedItem == item ? nil : item
    }
}
