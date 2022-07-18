//
//  NewExpense.swift
//  Expence Task
//
//  Created by nyannyan0328 on 2022/05/21.
//

import SwiftUI

struct NewExpense: View {
    @EnvironmentObject var expenseViewModel : ExpeseViewModel
    @Environment(\.self) var env
    var body: some View {
        VStack{
            
            VStack(spacing:15){
                
                
                Text("All Expenses")
                    .font(.title2.weight(.semibold))
                    .opacity(0.5)
                
                
                if let symbol = expenseViewModel.convertNumberToPrice(value: 0).first{
                    
                    TextField("0", text: $expenseViewModel.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            
                            
                            Text(expenseViewModel.amount == "" ? "0" : expenseViewModel.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading) {
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                    
                                }
                        }
                    
                    
                    
                       
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .background{
                            
                            
                            Capsule()
                                .fill(.white)
                            
                        }
                        .padding(.horizontal,20)
                        .padding(.top)
                }
                
                
                
                Label {
                    
                    TextField("Remark",text : $expenseViewModel.remark)
                        .padding(.leading,10)
                    
                } icon: {
                    
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                    
                    
                    
                }
                .padding(.top,25)
                
                
                
                
                Label {
                    
                    
                CustomCheckBoxes()
                    
                  
                    
                } icon: {
                    
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                    
                    
                    
                }
                .padding(.top,25)
                
                
                
                Label {
                    
                    DatePicker.init("", selection: $expenseViewModel.date,in: Date.distantPast...Date(), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                    
                } icon: {
                    
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                    
                    
                    
                }
                .padding(.top,5)
                

                
            }
            .frame(maxHeight: .infinity,alignment: .center)
            
            
            Button {
                
                expenseViewModel.saveData(env: env)
                
            } label: {
                
                Text("Save")
                    .font(.title3.weight(.semibold))
                    .padding(.vertical,15)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .background{
                        
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                            
                            
                                LinearGradient(colors: [
                                
                                    
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3"),
                                
                                
                                
                                ], startPoint: .topLeading, endPoint: .bottomLeading)
                            
                            )
                        
                        
                    }
                    .foregroundColor(.white)
                    .padding(.bottom,10)
                
                    
            }
            .disabled(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "")
            .opacity(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == ""  ? 0.6 : 1)

            
        }
       .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background{
          
          Color("BG").ignoresSafeArea()
      }
      .overlay(alignment: .topTrailing) {
          
          
          Button {
              env.dismiss()
          } label: {
              
              
              Image(systemName: "xmark")
                  .font(.title2)
                  .foregroundColor(.gray)
                  .opacity(0.7)
          }
          .padding()

      }
    }
    @ViewBuilder
    func CustomCheckBoxes()->some View{
        
        
        HStack(spacing:10){
            
            
            ForEach([ExpenseType.income,ExpenseType.expense],id:\.self){type in
                
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black,lineWidth: 2)
                        .opacity(5)
                        .frame(width: 20, height: 20)
                    
                    
                    if expenseViewModel.type == type{
                        
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    expenseViewModel.type = type
                }
                
                
                Text(type.rawValue.capitalized)
                    .font(.callout.weight(.semibold))
                    .opacity(0.7)
                    .padding(.trailing)
                
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading,10)
        
        
        
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense()
            .environmentObject(ExpeseViewModel())
    }
}
