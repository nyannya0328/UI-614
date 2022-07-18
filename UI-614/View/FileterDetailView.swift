//
//  FileterDetailView.swift
//  Expence Task
//
//  Created by nyannyan0328 on 2022/05/21.
//

import SwiftUI

struct FileterDetailView: View {
    @EnvironmentObject var exepeceViewModel : ExpeseViewModel
    @Environment(\.self) var env
    
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                
                HStack(spacing:15){
                    
                    
                    Button {
                        
                        env.dismiss()
                        
                    } label: {
                        
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        
                    }
                    
                    
                    
                    
                    
                    Text("Transaction")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    
                    
                    Button {
                        
                        exepeceViewModel.showFileterView = true
                        
                    } label: {
                        
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    
                    
                    
                }
                
                ExpenseCardView(isFileter:true)
                    .environmentObject(exepeceViewModel)
                
                CustomSegnetedControl()
                    .padding(.top)
                
                VStack(spacing:15){
                    
                    
                    Text(exepeceViewModel.convertDateToString())
                        .opacity(0.7)
                    
                    Text(exepeceViewModel.convertExpesesToCurrency(expenses: exepeceViewModel.expenses, type: exepeceViewModel.tabName))
                        .font(.title2.bold())
                        .opacity(0.9)
                        .animation(.none, value: exepeceViewModel.tabName)
                    
                    
                    
                    
                }
                .padding()
                 .frame(maxWidth: .infinity,alignment: .center)
                 .background{
                     
                     
                     RoundedRectangle(cornerRadius: 15, style: .continuous)
                         .fill(.white)
                 }
                 .padding(.vertical,20)
                
                
                
                ForEach(exepeceViewModel.expenses.filter{//一回きる
                    
                    
                    return $0.type == exepeceViewModel.tabName
                    
                }){exp in
                    
                    TransactionCardView(expense: exp)
                        .environmentObject(exepeceViewModel)
                    
                    
                }
                
                
                
            }
            .padding()
            
        }
        .navigationBarHidden(true)
        .background{
            
            Color("BG").ignoresSafeArea()
            
        }
        .overlay {
            
            FileterView()
        }
        
        
      
        
        
    }
    
    @ViewBuilder
    func FileterView()->some View{
        
        
        ZStack{
            
            
            Color.black
                .opacity(exepeceViewModel.showFileterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            if exepeceViewModel.showFileterView{
                
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                    
                    
                    DatePicker("", selection: $exepeceViewModel.startDate,in: Date.distantPast...Date(),displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top,10)
                    
                    
                    DatePicker("", selection: $exepeceViewModel.endData,in: Date.distantPast...Date(),displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background{
                    
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                    
                }
                .overlay(alignment: .topTrailing, content: {
                    
                    Button {
                        exepeceViewModel.showFileterView = false
                    } label: {
                        
                        
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }

                    
                    
                })
                .padding()
                
            }
            
            
        }
        .animation(.easeInOut, value: exepeceViewModel.showFileterView)
    }

    
    @ViewBuilder
    func CustomSegnetedControl()->some View{
        
        HStack(spacing:0){
            
            ForEach([ExpenseType.income,ExpenseType.expense],id:\.rawValue){tab in
                
                
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(exepeceViewModel.tabName == tab ? .white : .black)
                    .opacity(exepeceViewModel.tabName == tab ? 1 : 0.7)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .padding(.vertical,15)
                    .background{
                        
                        if exepeceViewModel.tabName == tab{
                            
                            
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                
                                
                                    LinearGradient(colors: [
                                    
                                        Color("Gradient1"),
                                        Color("Gradient2"),
                                        Color("Gradient3"),
                                    
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                            
                            
                        
                            
                        }
                        
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{
                            
                            exepeceViewModel.tabName = tab
                        }
                    }
                
                
                
                
            }
        }
        .padding(5)
        .background{
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
            
        }
        
    }
}

struct FileterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FileterDetailView()
            .environmentObject(ExpeseViewModel())
    }
}
