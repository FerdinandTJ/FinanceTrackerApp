//
//  EditTransactionView.swift
//  Finance App
//
//  Created by Timotheus Ferdinand Tjondrojo on 09/08/25.
//

import SwiftUI

struct EditTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let transaction: Transaction
    
    @State private var title: String
    @State private var amount: String
    @State private var selectedType: TransactionType
    @State private var selectedCategory: String
    @State private var date: Date
    @State private var notes: String
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    init(transaction: Transaction) {
        self.transaction = transaction
        self._title = State(initialValue: transaction.title)
        self._amount = State(initialValue: String(transaction.amount))
        self._selectedType = State(initialValue: transaction.type)
        self._selectedCategory = State(initialValue: transaction.category)
        self._date = State(initialValue: transaction.date)
        self._notes = State(initialValue: transaction.notes ?? "")
    }
    
    private var categories: [String] {
        selectedType == .income ? incomeCategories : expenseCategories
    }
    
    private let incomeCategories = ["Salary", "Business", "Investment", "Gift", "Bonus", "Other Income"]
    private let expenseCategories = ["Food & Dining", "Transportation", "Shopping", "Bills", "Entertainment", "Health", "Education", "Other Expense"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Transaction Details") {
                    TextField("Transaction Title", text: $title)
                        .textInputAutocapitalization(.words)
                    
                    HStack {
                        Text("IDR")
                            .foregroundColor(.secondary)
                            .font(.headline)
                        TextField("0", text: $amount)
                            .keyboardType(.numberPad)
                            .font(.headline)
                    }
                }
                
                Section("Transaction Type") {
                    HStack(spacing: 0) {
                        // Income Button
                        Button(action: {
                            selectedType = .income
                            if !incomeCategories.contains(selectedCategory) {
                                selectedCategory = ""
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.green)
                                Text("Income")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedType == .income ? Color.green.opacity(0.1) : Color.clear)
                            .foregroundColor(selectedType == .income ? .green : .primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Expense Button
                        Button(action: {
                            selectedType = .expense
                            if !expenseCategories.contains(selectedCategory) {
                                selectedCategory = ""
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundColor(.red)
                                Text("Expense")
                                    .fontWeight(.medium)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedType == .expense ? Color.red.opacity(0.1) : Color.clear)
                            .foregroundColor(selectedType == .expense ? .red : .primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Section("Category") {
                    Picker("Select Category", selection: $selectedCategory) {
                        Text("Choose Category").tag("")
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Date & Time") {
                    DatePicker("Transaction Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Notes (Optional)") {
                    TextField("Add notes about this transaction", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
                
                // Preview Section
                if !title.isEmpty && !amount.isEmpty && !selectedCategory.isEmpty {
                    Section("Preview") {
                        TransactionPreviewRow(
                            title: title,
                            amount: Double(amount) ?? 0,
                            type: selectedType,
                            category: selectedCategory,
                            date: date
                        )
                    }
                }
            }
            .navigationTitle("Edit Transaction")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        updateTransaction()
                    }
                    .disabled(!isValidInput)
                    .foregroundColor(isValidInput ? .blue : .gray)
                    .fontWeight(.semibold)
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var isValidInput: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !amount.isEmpty &&
        !selectedCategory.isEmpty &&
        Double(amount) != nil &&
        (Double(amount) ?? 0) > 0
    }
    
    private func updateTransaction() {
        guard let amountValue = Double(amount), amountValue > 0 else {
            alertMessage = "Please enter a valid amount greater than 0"
            showingAlert = true
            return
        }
        
        withAnimation {
            transaction.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
            transaction.amount = amountValue
            transaction.type = selectedType
            transaction.category = selectedCategory
            transaction.date = date
            transaction.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : notes.trimmingCharacters(in: .whitespacesAndNewlines)
            
            dismiss()
        }
    }
}

struct TransactionPreviewRow: View {
    let title: String
    let amount: Double
    let type: TransactionType
    let category: String
    let date: Date
    
    var body: some View {
        HStack {
            Image(systemName: type.icon)
                .foregroundColor(type.color)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(category)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(type.symbol)\(formatIDR(amount))")
                .font(.headline)
                .foregroundColor(type.color)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

private func formatIDR(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "IDR"
    formatter.locale = Locale(identifier: "id_ID")
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: amount)) ?? "IDR 0"
}

#Preview {
    let sampleTransaction = Transaction(
        title: "Sample Transaction",
        amount: 50000,
        type: .expense,
        category: "Food & Dining",
        date: Date(),
        notes: "Sample notes"
    )
    
    EditTransactionView(transaction: sampleTransaction)
        .modelContainer(for: Transaction.self, inMemory: true)
}