//
//  ExpenseCardView.swift
//  Expence Task
//
//  Created by nyannyan0328 on 2022/05/21.
//

import SwiftUI

struct ExpenseCardView: View {
    @EnvironmentObject var expenseViewModel : ExpeseViewModel
    var isFileter : Bool = false
    var body: some View {
        GeometryReader{proxy in
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                
                    
                    LinearGradient(colors: [
                    
                    Color("Gradient1"),
                    Color("Gradient2"),
                    Color("Gradient3"),
                    
                    
                    
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                
                
                )
            
            
            VStack(spacing:15){
                
                VStack(spacing:15){
                    
                    
                    Text(isFileter ? expenseViewModel.convertDateToString() : expenseViewModel.currentMonthDateString())//func
                        .font(.callout.weight(.semibold))
                    
                    Text(expenseViewModel.convertExpesesToCurrency(expenses: expenseViewModel.expenses))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom,5)
                    
                    
                    
                    
                }
                .offset(y: -10)
                
                
                HStack(spacing:15){
                    
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(expenseViewModel.convertExpesesToCurrency(expenses: expenseViewModel.expenses, type: .income))
                            .font(.callout.weight(.semibold))
                            .lineLimit(1)
                            .fixedSize()
                        
                        
                    }
                   .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color("Red"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Expenses")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(expenseViewModel.convertExpesesToCurrency(expenses: expenseViewModel.expenses, type: .expense))
                            .font(.callout.weight(.semibold))
                            .lineLimit(1)
                            .fixedSize()
                        
                        
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
            
        }
        .frame(height: 220)
        .addSpotLight(1,shape: .rounded,roundRaidus: 20,title: "Ongoing Status")
        .padding(.top)
        
    }
    
   
}
