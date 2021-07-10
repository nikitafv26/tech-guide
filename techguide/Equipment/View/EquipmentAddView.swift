//
//  EquipmentTypeDetailView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 03.07.2021.
//

import SwiftUI

struct AlertMessage: Identifiable {
    let id = UUID()
    let text: String
}

struct EquipmentAddView: View {
    
    var type: String
    @State var name: String = ""
    @Binding var popToRootView: Bool

    //@Binding var shouldPopToRootView: Bool
    
    let onComplete: (String) -> Void
    
    @State private var message: AlertMessage? = nil
    
    var body: some View {
        Form {
            Section(header: Text("Name")){
                TextField("Name", text: $name)
            }
            Section{
                HStack{
                    Spacer()
                    Button(action: {
                        addEquipment()
                    }, label: {
                        Text("Add")
                    })
                    Spacer()
                }
            }
            .navigationTitle(Text(type))
        }
        .alert(item: $message) { msg in
            Alert(
                title: Text(msg.text),
                dismissButton: .cancel())
        }
    }
    
    func addEquipment(){
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.message = AlertMessage(text: "Name for \(type) should not be empty")
            return
        }
        self.popToRootView = false
        onComplete(self.name)
    }
}
