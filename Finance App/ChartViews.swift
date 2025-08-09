//
//  ChartViews.swift
//  Finance App
//
//  Created by Timotheus Ferdinand Tjondrojo on 09/08/25.
//

import SwiftUI
import SwiftData
import Charts

// MARK: - Supporting Types

struct CategoryStat {
    let category: String
    let total: Double
    let count: Int
    let type: TransactionType
}

struct MonthlyData {
    let month: Date
    let income: Double
    let expense: Double
}

// MARK: - Chart Views

struct ExpensePieChartView: View {
    let categoryStats: [CategoryStat]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Expense Distribution")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if !categoryStats.isEmpty {
                Chart(categoryStats.prefix(6), id: \.category) { stat in
                    SectorMark(
                        angle: .value("Amount", stat.total),
                        innerRadius: .ratio(0.4),
                        angularInset: 2
                    )
                    .foregroundStyle(by: .value("Category", stat.category))
                    .opacity(0.8)
                }
                .frame(height: 300)
                .padding(.horizontal)
                
                // Legend
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                    ForEach(categoryStats.prefix(6), id: \.category) { stat in
                        HStack(spacing: 8) {
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 8, height: 8)
                            Text(stat.category)
                                .font(.caption)
                                .lineLimit(1)
                            Spacer()
                            Text(formatIDR(stat.total))
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                // Empty State
                VStack(spacing: 16) {
                    Image(systemName: "chart.pie")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No expense data available")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}

struct CategoryBarChartView: View {
    let categoryStats: [CategoryStat]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Category Spending")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if !categoryStats.isEmpty {
                Chart(categoryStats.prefix(8), id: \.category) { stat in
                    BarMark(
                        x: .value("Amount", stat.total),
                        y: .value("Category", stat.category)
                    )
                    .foregroundStyle(.red.gradient)
                    .cornerRadius(4)
                }
                .frame(height: max(250, CGFloat(categoryStats.prefix(8).count) * 35))
                .chartXAxis {
                    AxisMarks { value in
                        AxisValueLabel {
                            if let amount = value.as(Double.self) {
                                Text(formatIDRShort(amount))
                            }
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                // Empty State
                VStack(spacing: 16) {
                    HStack(spacing: 4) {
                        ForEach(0..<4) { _ in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 20)
                                .frame(height: CGFloat.random(in: 30...80))
                        }
                    }
                    Text("No category data available")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}

struct MonthlyTrendChartView: View {
    let monthlyData: [MonthlyData]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Monthly Trends")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if !monthlyData.isEmpty {
                Chart(monthlyData, id: \.month) { data in
                    LineMark(
                        x: .value("Month", data.month, unit: .month),
                        y: .value("Income", data.income)
                    )
                    .foregroundStyle(.green)
                    .symbol(.circle)
                    
                    LineMark(
                        x: .value("Month", data.month, unit: .month),
                        y: .value("Expense", data.expense)
                    )
                    .foregroundStyle(.red)
                    .symbol(.square)
                }
                .frame(height: 200)
                .chartYAxis {
                    AxisMarks { value in
                        AxisValueLabel {
                            if let amount = value.as(Double.self) {
                                Text(formatIDRShort(amount))
                            }
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
                        AxisValueLabel(format: .dateTime.month(.abbreviated))
                    }
                }
                .padding(.horizontal)
                
                // Legend
                HStack(spacing: 20) {
                    Label("Income", systemImage: "circle.fill")
                        .foregroundColor(.green)
                    Label("Expense", systemImage: "square.fill")
                        .foregroundColor(.red)
                }
                .font(.caption)
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}

// MARK: - Helper Functions

private func formatIDR(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "IDR"
    formatter.locale = Locale(identifier: "id_ID")
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: amount)) ?? "IDR 0"
}

private func formatIDRShort(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "IDR"
    formatter.locale = Locale(identifier: "id_ID")
    formatter.maximumFractionDigits = 0
    
    if amount >= 1_000_000 {
        let millions = amount / 1_000_000
        return "IDR \(String(format: "%.1f", millions))M"
    } else if amount >= 1_000 {
        let thousands = amount / 1_000
        return "IDR \(String(format: "%.1f", thousands))K"
    }
    
    return formatter.string(from: NSNumber(value: amount)) ?? "IDR 0"
}

#Preview {
    let sampleStats = [
        CategoryStat(category: "Food & Dining", total: 500000, count: 10, type: .expense),
        CategoryStat(category: "Transportation", total: 300000, count: 5, type: .expense),
        CategoryStat(category: "Shopping", total: 200000, count: 3, type: .expense)
    ]
    
    VStack {
        ExpensePieChartView(categoryStats: sampleStats)
        CategoryBarChartView(categoryStats: sampleStats)
    }
}
