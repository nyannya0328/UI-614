//
//  Home.swift
//  Expence Task
//
//  Created by nyannyan0328 on 2022/05/21.
//

import SwiftUI

struct Home: View {
    @StateObject var expenseViewModel : ExpeseViewModel = .init()
    
    @State var showSpotLight : Bool = false
    @State var currentSpot : Int = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                
                HStack(spacing:15){
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Welcome!")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.gray)
                        
                        Text("Jacob")
                            .font(.title2.bold())
                        
                    }
                     .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    NavigationLink {
                        
                        FileterDetailView()
                            .environmentObject(expenseViewModel)
                        
                    } label: {
                        
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                
                                Circle()
                                    .stroke(.white,lineWidth: 2)
                                    .padding(2)
                                
                            })
                            .frame(width: 40, height: 40)
                            .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    .addSpotLight(0,shape: .rounded,roundRaidus: 10,title: "Expences Filetering")

                    
                }
                
              ExpenseCardView()
                    .environmentObject(expenseViewModel)
                TransactionsView()
            }
            .padding()
        }
        .background{
            
            Color("BG").ignoresSafeArea()
                
        }
        .fullScreenCover(isPresented: $expenseViewModel.addNewExpense) {
            
            expenseViewModel.clearData()
            
        } content: {
            NewExpense()
                .environmentObject(expenseViewModel)
        }
        .overlay(alignment: .bottomTrailing) {
            
            AddButon()
        }
        .addSpotlightOveray(show: $showSpotLight, currentSpot: $currentSpot)
        .onAppear{
            
            showSpotLight = true
        }

    }
    
    @ViewBuilder
    func AddButon()->some View{
        
        Button {
            
            expenseViewModel.addNewExpense.toggle()
            
        } label: {
            
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    
                 Circle()
                        .fill(
                        
                            LinearGradient(colors: [
                            
                                
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3"),
                            
                            
                            
                            ], startPoint: .topLeading, endPoint: .bottomLeading)
                        
                        
                        
                        )
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        
                    
                    
                }
        }
        .addSpotLight(3,shape:.circle,title: "Addinge New Expence\nTo the App")
        .padding()
      

    }
    @ViewBuilder
    func TransactionsView()->some View{
        
        VStack(spacing:15){
            
            Text("Transactions")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom)
            
            ForEach(expenseViewModel.expenses){expense in
                
                
                if expense.id == expenseViewModel.expenses.first?.id{
                    
                    
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseViewModel)
                        .addSpotLight(2,shape: .rectangle,roundRaidus: 15,title: "Transaction Details")
                    
                    
                }
                else{
                    
                    
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseViewModel)
                }
                
                
            }
            
        }
        .padding(.top)
        
    }
    @ViewBuilder
    func expenseCardView()->some View{
        
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
                    
                    
                    Text(expenseViewModel.currentMonthDateString())//func
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
        .padding(.top)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
