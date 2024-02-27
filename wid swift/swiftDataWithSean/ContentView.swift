//
//  ContentView.swift
//  swiftDataWithSean
//
//  Created by rania on 19/06/1445 AH.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   
//    @Query to fitch
    @Query(sort:\Expense.date) var expenses : [Expense] // this query to fitch and the order of expence based on the date
    @State private var expenseToEdit: Expense?
    @Environment (\.modelContext) var context
    @State private var isShowingItemSheet = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses){ expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                          expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                }
                
            }
            .navigationTitle("Expenses")
                .sheet(isPresented: $isShowingItemSheet){ AddExpenseSheet()}
                .sheet(item: $expenseToEdit){expense in
                    UpdateExpenseSheet(expense: expense)
                }
                .toolbar {
                    if !expenses.isEmpty{
                        Button("Add Expense",systemImage: "plus"){
                            isShowingItemSheet = true
                        }
                    }
                }.overlay{
                    
                    if expenses.isEmpty{
                        ContentUnavailableView(label: {
                            Label("No Expence",systemImage: "list.bullet.rectangle.portrait")
                                               
                        }, description: {
                            Text("Start adding expences to see your List.")
                        }, actions: {
                            Button("Adding Expense"){isShowingItemSheet = true }
                        }).offset(y: -60)
                    }
                    
                }
        }.background(.colorPerpleDark)
    }
}

#Preview {
    ContentView()
}

struct ExpenseCell : View {
    
    let expense : Expense
    var body: some View{
        HStack{
            
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
            
        }
        
    }
    
    
}

struct AddExpenseSheet: View{
    @Environment (\.modelContext) var context // we can access it because we declear in schema befor
    @Environment(\.dismiss) private var dismiss
    @State private var name : String = ""
    @State private var date: Date = .now
    @State private var value : Double = 0
    
    var body: some View{
        NavigationStack{
            
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date",selection: $date,displayedComponents: .date)
                TextField("Value", value: $value ,format: .currency(code: "USD"))
                    
            }.background(.red)
            .navigationTitle("New Expence")
                .toolbar{
                    ToolbarItemGroup(placement:.topBarLeading){
                        Button("Cancel"){dismiss()}
                    }
                    ToolbarItemGroup(placement:.topBarTrailing){
                        Button("Save"){
                            let expense = Expense(name: name, date: date, value: value)
                            context.insert(expense)
                            dismiss()
                        }
                    }
                    
                }
        }.background(.red)
        
    }
    
}

struct UpdateExpenseSheet: View{
   
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense :Expense
    
    
    var body: some View{
        NavigationStack{
            
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date",selection: $expense.date,displayedComponents: .date)
                TextField("Value", value: $expense.value ,format: .currency(code: "USD"))
                
            }
            .navigationTitle("Update Expense")
                .toolbar{
                    ToolbarItemGroup(placement: .topBarLeading){
                        Button("Done"){dismiss()}
                    }
                    
                }
        }
        
    }
    
}
