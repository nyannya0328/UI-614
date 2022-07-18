//
//  ExpeseViewModel.swift
//  Expence Task
//
//  Created by nyannyan0328 on 2022/05/21.
//

import SwiftUI

class ExpeseViewModel: ObservableObject {
    
    @Published var startDate : Date = Date()
    @Published var endData : Date = Date()
    @Published var currentMonthStartDate : Date = Date()
    @Published var expenses : [Expense] = sample_expenses
    
    @Published var tabName : ExpenseType = .expense
    
    @Published var showFileterView : Bool = false
    
    @Published var addNewExpense : Bool = false
    @Published var amount : String = ""
    @Published var type : ExpenseType = .all
    @Published var date : Date = Date()
    @Published var remark : String = ""
    
    
    init() {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: Date())
        
        
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from:components)!
    
    }
    
    
    func currentMonthDateString()->String{//formate
        
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertDateToString() -> String{
        
        
       return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endData.formatted(date:.abbreviated, time: .omitted)
        
    }
    
    func convertExpesesToCurrency(expenses : [Expense],type : ExpenseType = .all) -> String{
        
        var value : Double = 0
        
        value = expenses.reduce(0, { partialResult, expense in
            
            return partialResult + (type == .all ? (expense.type == .income ? expense.amount : -expense.amount)  : (expense.type == type ? expense.amount : 0))
        })
        
      return convertNumberToPrice(value: value)
        
    }
    
    
    func convertNumberToPrice(value : Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "$0.00"
        
    }
    
    func clearData(){
        
        
        date = Date()
        type = .all
        remark = ""
        amount = ""
    }
    
    func saveData(env : EnvironmentValues){
        
        
        let amountInDouble = (amount as NSString).doubleValue
        
        let colors = ["Yellow","Red","Purple","Green"]
        
        
        let expense = Expense(remark: remark, amount: amountInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow")
        
        withAnimation{
            
            expenses.append(expense)
            
        }
        
        expenses = expenses.sorted(by: { first, sec in
            return sec.date < first.date
        })
        env.dismiss()
        
        
        
        
        
    }
    
}


