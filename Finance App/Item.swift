//
//  Item.swift
//  Finance App
//
//  Created by Timotheus Ferdinand Tjondrojo on 09/08/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Transaction {
    var id: UUID
    var title: String
    var amount: Double
    var type: TransactionType
    var category: String
    var date: Date
    var notes: String?
    
    init(title: String, amount: Double, type: TransactionType, category: String, date: Date = Date(), notes: String? = nil) {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.notes = notes
    }
}

enum TransactionType: String, CaseIterable, Codable {
    case income = "Income"
    case expense = "Expense"
    
    var color: Color {
        switch self {
        case .income:
            return .green
        case .expense:
            return .red
        }
    }
    
    var symbol: String {
        switch self {
        case .income:
            return "+"
        case .expense:
            return "-"
        }
    }
    
    var icon: String {
        switch self {
        case .income:
            return "arrow.up.circle.fill"
        case .expense:
            return "arrow.down.circle.fill"
        }
    }
}
