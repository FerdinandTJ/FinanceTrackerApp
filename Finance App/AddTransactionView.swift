//
//  AddTransactionView.swift
//  Finance App
//
//  Created by Timotheus Ferdinand Tjondrojo on 09/08/25.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var amount = ""
    @State private var selectedType: TransactionType = .expense
    @State private var selectedCategory = ""
    @State private var date = Date()
    @State private var notes = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    private var categories: [String] {
        selectedType == .income ? incomeCategories : expenseCategories
    }
    
    private let incomeCategories = ["Salary", "Business", "Investment", "Gift", "Bonus", "Other Income"]
    private let expenseCategories = ["Food & Dining", "Transportation", "Shopping", "Bills", "Entertainment", "Health", "Education", "Other Expense"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Enhanced Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGray6).opacity(0.3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header Icon
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [
                                        Color.blue.opacity(0.1),
                                        Color.blue.opacity(0.05)
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .frame(width: 80, height: 80)
                                .shadow(color: .blue.opacity(0.2), radius: 15, x: 0, y: 8)
                            
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 20) {
                            // Transaction Details Card
                            ModernFormCard {
                                VStack(spacing: 16) {
                                    ModernFormHeader(title: "Transaction Details", icon: "doc.text.fill")
                                    
                                    ModernTextField(
                                        title: "Title",
                                        text: $title,
                                        placeholder: "Enter transaction title",
                                        icon: "textformat"
                                    )
                                    
                                    ModernAmountField(
                                        title: "Amount",
                                        amount: $amount,
                                        placeholder: "0"
                                    )
                                }
                            }
                            
                            // Transaction Type Card
                            ModernFormCard {
                                VStack(spacing: 16) {
                                    ModernFormHeader(title: "Transaction Type", icon: "arrow.up.arrow.down")
                                    
                                    HStack(spacing: 12) {
                                        // Income Button
                                        ModernTypeButton(
                                            title: "Income",
                                            icon: "arrow.up.circle.fill",
                                            color: .green,
                                            isSelected: selectedType == .income
                                        ) {
                                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                selectedType = .income
                                                selectedCategory = ""
                                            }
                                        }
                                        
                                        // Expense Button
                                        ModernTypeButton(
                                            title: "Expense",
                                            icon: "arrow.down.circle.fill",
                                            color: .red,
                                            isSelected: selectedType == .expense
                                        ) {
                                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                selectedType = .expense
                                                selectedCategory = ""
                                            }
                                        }
                                    }
                                }
                            }
                            
                            // Category Card
                            ModernFormCard {
                                VStack(spacing: 16) {
                                    ModernFormHeader(title: "Category", icon: "folder.fill")
                                    
                                    ModernCategoryPicker(
                                        selectedCategory: $selectedCategory,
                                        categories: categories,
                                        type: selectedType
                                    )
                                }
                            }
                            
                            // Date Card
                            ModernFormCard {
                                VStack(spacing: 16) {
                                    ModernFormHeader(title: "Date & Time", icon: "calendar")
                                    
                                    DatePicker("Select Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                                        .datePickerStyle(CompactDatePickerStyle())
                                        .font(.system(size: 16, weight: .medium))
                                }
                            }
                            
                            // Notes Card
                            ModernFormCard {
                                VStack(spacing: 16) {
                                    ModernFormHeader(title: "Notes (Optional)", icon: "note.text")
                                    
                                    ModernNotesField(notes: $notes)
                                }
                            }
                            
                            // Preview Card
                            if !title.isEmpty && !amount.isEmpty && !selectedCategory.isEmpty {
                                ModernFormCard {
                                    VStack(spacing: 16) {
                                        ModernFormHeader(title: "Preview", icon: "eye.fill")
                                        
                                        EnhancedTransactionPreviewRow(
                                            title: title,
                                            amount: Double(amount) ?? 0,
                                            type: selectedType,
                                            category: selectedCategory,
                                            date: date
                                        )
                                    }
                                }
                                .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveTransaction()
                    }
                    .disabled(!isValidInput)
                    .foregroundColor(isValidInput ? .blue : .gray)
                    .fontWeight(.semibold)
                    .scaleEffect(isValidInput ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isValidInput)
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
        !title.isEmpty && !amount.isEmpty && !selectedCategory.isEmpty && Double(amount) != nil
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount) else { return }
        
        let transaction = Transaction(
            title: title,
            amount: amountValue,
            type: selectedType,
            category: selectedCategory,
            date: date,
            notes: notes.isEmpty ? nil : notes
        )
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            modelContext.insert(transaction)
            dismiss()
        }
    }
}

// MARK: - Enhanced Form Components

struct ModernFormCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 15, x: 0, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray6), lineWidth: 0.5)
                )
        )
    }
}

struct ModernFormHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.blue)
            }
            
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct ModernTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 20)
                
                TextField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 16))
                    .textInputAutocapitalization(.words)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 0.5)
                    )
            )
        }
    }
}

struct ModernAmountField: View {
    let title: String
    @Binding var amount: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 28, height: 28)
                    Text("IDR")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.green)
                }
                
                TextField(placeholder, text: $amount)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 18, weight: .semibold))
                    .keyboardType(.numberPad)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 0.5)
                    )
            )
        }
    }
}

struct ModernTypeButton: View {
    let title: String
    let icon: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? color.opacity(0.15) : Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? color.opacity(0.5) : Color.clear, lineWidth: 2)
                    )
                    .shadow(color: isSelected ? color.opacity(0.2) : .clear, radius: 8, x: 0, y: 4)
            )
            .foregroundColor(isSelected ? color : .primary)
            .scaleEffect(isSelected ? 1.02 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ModernCategoryPicker: View {
    @Binding var selectedCategory: String
    let categories: [String]
    let type: TransactionType
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 12) {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedCategory = category
                    }
                }) {
                    HStack {
                        Text(category)
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                        Spacer()
                        if selectedCategory == category {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(type.color)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selectedCategory == category ? type.color.opacity(0.1) : Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCategory == category ? type.color.opacity(0.3) : Color.clear, lineWidth: 1)
                            )
                    )
                    .foregroundColor(selectedCategory == category ? type.color : .primary)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ModernNotesField: View {
    @Binding var notes: String
    
    var body: some View {
        TextField("Add notes about this transaction...", text: $notes, axis: .vertical)
            .textFieldStyle(PlainTextFieldStyle())
            .font(.system(size: 16))
            .lineLimit(3...6)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 0.5)
                    )
            )
    }
}

struct EnhancedTransactionPreviewRow: View {
    let title: String
    let amount: Double
    let type: TransactionType
    let category: String
    let date: Date
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(type.color.opacity(0.15))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Circle()
                            .stroke(type.color.opacity(0.3), lineWidth: 1)
                    )
                
                Image(systemName: type.icon)
                    .foregroundColor(type.color)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(category)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.secondary)
                
                Text(date, style: .date)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(type.symbol)\(formatIDR(amount))")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(type.color)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6).opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(type.color.opacity(0.2), lineWidth: 1)
                )
        )
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
    AddTransactionView()
}
