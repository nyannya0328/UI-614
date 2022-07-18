//
//  TransactionCardView.swift
//  Expence Task
//
//  Created by nyannyan0328 on 2022/05/21.
//

import SwiftUI

struct TransactionCardView: View {
    
    var expense : Expense
    @EnvironmentObject var exepeceViewModel : ExpeseViewModel
    var body: some View {
        
        HStack(spacing:15){
            
            if let first = expense.remark.first{
                
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background{
                        
                        Circle()
                            .fill(Color(expense.color))
                        
                    }
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                
            }
            
            
            Text(expense.remark)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            VStack(alignment: .leading, spacing: 7) {
                
                
                let price = exepeceViewModel.convertNumberToPrice(value:expense.type == .expense ? -expense.amount : expense.amount)
                
                Text(price)
                    .font(.callout)
                    .foregroundColor(expense.type == .expense ? Color("Red") : Color("Green"))
                    .opacity(0.7)
                
                Text(expense.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .opacity(0.5)
                
            }
                
        }
        .padding()
        .background{
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
            
        }
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
