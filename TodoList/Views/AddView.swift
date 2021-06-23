//
//  AddView.swift
//  TodoList
//
//  Created by Ome Asraf on 6/23/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            TextField("Type something here...", text: $textFieldText)
                .foregroundColor(.white)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                .cornerRadius(10)
            
            Button(action: saveButtonPressed, label: {
                Text("Save".uppercased())
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    
            })
        }
        .padding(14)
        .navigationTitle("Add an item 🖋")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        else{
            
        }
    }
    
    func textIsAppropriate() -> Bool{
        if  textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long 😵😵"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
