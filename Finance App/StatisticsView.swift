//
//  StatisticsView.swift
//  Finance App
//
//  Created by Timotheus Ferdinand Tjondrojo on 09/08/25.
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
    @Query private var transactions: [Transaction]
    @State private var selectedPeriod: StatsPeriod = .thisMonth
    @State private var selectedChartType: ChartType = .pie
    
    private var filteredTransactions: [Transaction] {
        let calendar = Calendar.current
        let now = Date()
        
        switch selectedPeriod {
        case .thisWeek:
            return transactions.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .weekOfYear) }
        case .thisMonth:
            return transactions.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
        case .thisYear:
            return transactions.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .year) }
        case .all:
            return transactions
        }
    }
    
    private var categoryStats: [CategoryStat] {
        let grouped = Dictionary(grouping: filteredTransactions) { $0.category }
        return grouped.map { category, transactions in
            let total = transactions.reduce(0) { $0 + $1.amount }
            let count = transactions.count
            let type = transactions.first?.type ?? .expense
            return CategoryStat(category: category, total: total, count: count, type: type)
        }.sorted { $0.total > $1.total }
    }
    
    private var expenseStats: [CategoryStat] {
        categoryStats.filter { $0.type == .expense }
    }
    
    private var monthlyData: [MonthlyData] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: filteredTransactions) { transaction in
            calendar.dateInterval(of: .month, for: transaction.date)?.start ?? transaction.date
        }
        
        return grouped.map { month, transactions in
            let income = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
            let expense = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
            return MonthlyData(month: month, income: income, expense: expense)
        }.sorted { $0.month < $1.month }
    }
    
    private var totalIncome: Double {
        filteredTransactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }
    
    private var totalExpense: Double {
        filteredTransactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Period Selector
                    Picker("Period", selection: $selectedPeriod) {
                        ForEach(StatsPeriod.allCases, id: \.self) { period in
                            Text(period.rawValue).tag(period)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Overview Cards
                    HStack(spacing: 16) {
                        StatCard(title: "Total Income", amount: totalIncome, color: .green, icon: "arrow.up.circle")
                        StatCard(title: "Total Expense", amount: totalExpense, color: .red, icon: "arrow.down.circle")
                    }
                    .padding(.horizontal)
                    
                    StatCard(
                        title: "Net Income",
                        amount: totalIncome - totalExpense,
                        color: (totalIncome - totalExpense) >= 0 ? .blue : .orange,
                        icon: "chart.line.uptrend.xyaxis"
                    )
                    .padding(.horizontal)
                    
                    // Charts Section
                    if !filteredTransactions.isEmpty {
                        VStack(spacing: 20) {
                            // Chart Type Selector
                            Picker("Chart Type", selection: $selectedChartType) {
                                ForEach(ChartType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                            
                            // Charts
                            switch selectedChartType {
                            case .pie:
                                ExpensePieChartView(categoryStats: expenseStats)
                            case .bar:
                                CategoryBarChartView(categoryStats: expenseStats)
                            case .line:
                                MonthlyTrendChartView(monthlyData: monthlyData)
                            }
                        }
                    }
                    
                    // Category Breakdown
                    if !categoryStats.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Category Breakdown")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(categoryStats, id: \.category) { stat in
                                    CategoryStatRow(stat: stat, maxAmount: categoryStats.first?.total ?? 1)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Quick Insights
                    if !filteredTransactions.isEmpty {
                        InsightsView(transactions: filteredTransactions)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct StatCard: View {
    let title: String
    let amount: Double
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(formatIDR(amount))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct CategoryStatRow: View {
    let stat: CategoryStat
    let maxAmount: Double
    
    private var percentage: Double {
        guard maxAmount > 0 else { return 0 }
        return stat.total / maxAmount
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(stat.category)
                        .font(.headline)
                    Text("\(stat.count) transaction\(stat.count == 1 ? "" : "s")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(formatIDR(stat.total))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(stat.type.color)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(stat.type.color)
                        .frame(width: geometry.size.width * percentage, height: 6)
                        .cornerRadius(3)
                        .animation(.easeInOut(duration: 0.5), value: percentage)
                }
            }
            .frame(height: 6)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
    }
}

struct InsightsView: View {
    let transactions: [Transaction]
    
    private var averageDaily: Double {
        guard !transactions.isEmpty else { return 0 }
        let days = Set(transactions.map { Calendar.current.startOfDay(for: $0.date) }).count
        let totalExpense = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        return days > 0 ? totalExpense / Double(days) : 0
    }
    
    private var mostExpensiveTransaction: Transaction? {
        transactions.filter { $0.type == .expense }.max { $0.amount < $1.amount }
    }
    
    private var mostCommonCategory: String? {
        let categories = transactions.map { $0.category }
        let grouped = Dictionary(grouping: categories) { $0 }
        return grouped.max { $0.value.count < $1.value.count }?.key
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Insights")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                InsightCard(
                    title: "Average Daily Spending",
                    value: formatIDR(averageDaily),
                    icon: "calendar",
                    color: .blue
                )
                
                if let expensive = mostExpensiveTransaction {
                    InsightCard(
                        title: "Largest Expense",
                        value: "\(expensive.title) - \(formatIDR(expensive.amount))",
                        icon: "exclamationmark.triangle",
                        color: .red
                    )
                }
                
                if let common = mostCommonCategory {
                    InsightCard(
                        title: "Most Common Category",
                        value: common,
                        icon: "chart.pie",
                        color: .green
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct InsightCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.headline)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
    }
}

// MARK: - Enums (Remove duplicate definitions)

enum StatsPeriod: String, CaseIterable {
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case thisYear = "This Year"
    case all = "All Time"
}

enum ChartType: String, CaseIterable {
    case pie = "Pie Chart"
    case bar = "Bar Chart"
    case line = "Line Chart"
}

// Remove duplicate CategoryStat and MonthlyData definitions
// They are now defined in ChartViews.swift

private func formatIDR(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "IDR"
    formatter.locale = Locale(identifier: "id_ID")
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: amount)) ?? "IDR 0"
}

#Preview {
    StatisticsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
