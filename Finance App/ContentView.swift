//
//  ContentView.swift
//  Finance App
//
//  Created by Timotheus Ferdinand Tjondrojo on 09/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Transaction.date, order: .reverse) private var allTransactions: [Transaction]
    
    @State private var showingAddTransaction = false
    @State private var searchText = ""
    @State private var selectedFilter: TransactionFilter = .all
    @State private var selectedTimeFilter: TimeFilter = .all
    
    var body: some View {
        NavigationView {
            ZStack {
                // Enhanced Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 0.97, blue: 1.0),  // Light blue-white
                        Color(red: 0.92, green: 0.95, blue: 0.98), // Soft blue
                        Color(red: 0.88, green: 0.92, blue: 0.96)  // Deeper blue tint
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    // Enhanced Header with Search and Filters
                    VStack(spacing: 16) {
                        HStack {
                            TextField("Search transactions...", text: $searchText)
                                .textFieldStyle(ModernSearchFieldStyle())
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                FilterPill(title: "All", isSelected: selectedFilter == .all) {
                                    selectedFilter = .all
                                }
                                FilterPill(title: "Income", isSelected: selectedFilter == .income) {
                                    selectedFilter = .income
                                }
                                FilterPill(title: "Expense", isSelected: selectedFilter == .expense) {
                                    selectedFilter = .expense
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                    
                    // Summary Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            SummaryCard(
                                title: "Total Income",
                                amount: totalIncome,
                                color: Color(red: 0.2, green: 0.8, blue: 0.4),    // Modern green
                                icon: "arrow.up.circle.fill"
                            )
                            SummaryCard(
                                title: "Total Expense", 
                                amount: totalExpense,
                                color: Color(red: 1.0, green: 0.3, blue: 0.4),    // Vibrant red
                                icon: "arrow.down.circle.fill"
                            )
                            SummaryCard(
                                title: "Balance",
                                amount: balance,
                                color: balance >= 0 ? 
                                    Color(red: 0.3, green: 0.6, blue: 1.0) :      // Bright blue
                                    Color(red: 1.0, green: 0.6, blue: 0.2),       // Warm orange
                                icon: "creditcard.fill"
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    
                    // Transactions List
                    if filteredTransactions.isEmpty {
                        EmptyStateView()
                    } else {
                        List {
                            ForEach(filteredTransactions) { transaction in
                                TransactionRow(transaction: transaction)
                                    .listRowBackground(Color.clear)
                                    .swipeActions(edge: .trailing) {
                                        Button("Delete", role: .destructive) {
                                            deleteTransaction(transaction)
                                        }
                                        .tint(Color(red: 1.0, green: 0.2, blue: 0.3)) // Bright red
                                    }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Finance Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: StatisticsView()) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [
                                        Color(red: 0.4, green: 0.7, blue: 1.0),
                                        Color(red: 0.2, green: 0.5, blue: 0.9)
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .frame(width: 40, height: 40)
                                .shadow(color: Color(red: 0.2, green: 0.5, blue: 0.9).opacity(0.3), radius: 8, x: 0, y: 4)
                            
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTransaction = true }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [
                                        Color(red: 0.3, green: 0.9, blue: 0.5),
                                        Color(red: 0.2, green: 0.7, blue: 0.4)
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .frame(width: 40, height: 40)
                                .shadow(color: Color(red: 0.2, green: 0.7, blue: 0.4).opacity(0.3), radius: 8, x: 0, y: 4)
                            
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView()
            }
        }
    }
    
    private var filteredTransactions: [Transaction] {
        var transactions = allTransactions
        
        if !searchText.isEmpty {
            transactions = transactions.filter { transaction in
                transaction.title.localizedCaseInsensitiveContains(searchText) ||
                transaction.category.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        switch selectedFilter {
        case .income:
            transactions = transactions.filter { $0.type == .income }
        case .expense:
            transactions = transactions.filter { $0.type == .expense }
        case .all:
            break
        }
        
        return transactions
    }
    
    private var totalIncome: Double {
        filteredTransactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }
    
    private var totalExpense: Double {
        filteredTransactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }
    
    private var balance: Double {
        totalIncome - totalExpense
    }
    
    private func deleteTransaction(_ transaction: Transaction) {
        withAnimation {
            modelContext.delete(transaction)
        }
    }
}

// MARK: - Enhanced UI Components

struct ModernSearchFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(colors: [
                                    Color(red: 0.6, green: 0.8, blue: 1.0),
                                    Color(red: 0.4, green: 0.6, blue: 0.9)
                                ], startPoint: .leading, endPoint: .trailing),
                                lineWidth: 1
                            )
                    )
            )
    }
}

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            isSelected ? 
                            LinearGradient(colors: [
                                Color(red: 0.5, green: 0.7, blue: 1.0),
                                Color(red: 0.3, green: 0.5, blue: 0.9)
                            ], startPoint: .topLeading, endPoint: .bottomTrailing) :
                            LinearGradient(colors: [
                                Color.white,
                                Color(red: 0.95, green: 0.97, blue: 1.0)
                            ], startPoint: .top, endPoint: .bottom)
                        )
                        .shadow(color: isSelected ? 
                            Color(red: 0.3, green: 0.5, blue: 0.9).opacity(0.3) : 
                            Color.black.opacity(0.1), 
                            radius: isSelected ? 8 : 4, x: 0, y: 2)
                )
                .foregroundColor(isSelected ? .white : Color(red: 0.3, green: 0.4, blue: 0.6))
                .scaleEffect(isSelected ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SummaryCard: View {
    let title: String
    let amount: Double
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 18, weight: .semibold))
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.6))
                
                Text(formatIDR(amount))
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(color)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(width: 140, height: 90)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [
                        Color.white,
                        Color(red: 0.98, green: 0.99, blue: 1.0)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .shadow(color: color.opacity(0.2), radius: 12, x: 0, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(color.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    @State private var showingEditSheet = false
    
    var body: some View {
        Button(action: { showingEditSheet = true }) {
            HStack(spacing: 16) {
                // Enhanced icon with gradient background
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: [
                                transaction.type.color.opacity(0.2),
                                transaction.type.color.opacity(0.1)
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 48, height: 48)
                        .overlay(
                            Circle()
                                .stroke(transaction.type.color.opacity(0.3), lineWidth: 1.5)
                        )
                    
                    Image(systemName: transaction.type.icon)
                        .foregroundColor(transaction.type.color)
                        .font(.system(size: 20, weight: .semibold))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.4))
                    
                    Text(transaction.category)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color(red: 0.5, green: 0.6, blue: 0.7))
                }
                
                Spacer()
                
                Text("\(transaction.type.symbol)\(formatIDR(transaction.amount))")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(transaction.type.color)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(colors: [
                                    Color(red: 0.9, green: 0.95, blue: 1.0),
                                    Color(red: 0.85, green: 0.9, blue: 0.98)
                                ], startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 1
                            )
                    )
            )
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingEditSheet) {
            EditTransactionView(transaction: transaction)
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(colors: [
                            Color(red: 0.6, green: 0.8, blue: 1.0).opacity(0.3),
                            Color(red: 0.4, green: 0.6, blue: 0.9).opacity(0.1)
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 120, height: 120)
                
                Image(systemName: "tray")
                    .font(.system(size: 50, weight: .light))
                    .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.8))
            }
            
            VStack(spacing: 8) {
                Text("No transactions yet")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(red: 0.3, green: 0.4, blue: 0.5))
                
                Text("Tap the + button to add your first transaction")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.5, green: 0.6, blue: 0.7))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(40)
    }
}

// MARK: - Enums

enum TransactionFilter: CaseIterable {
    case all, income, expense
}

enum TimeFilter: CaseIterable {
    case all, today, thisWeek, thisMonth
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

#Preview {
    ContentView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
