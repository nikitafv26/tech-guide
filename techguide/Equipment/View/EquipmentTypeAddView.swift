//
//  EquipmentTypeAddView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 28.06.2021.
//

import SwiftUI

struct EquipmentTypeAddView: View {
    
    @State var name = ""
    
    let onComplete: (String) -> Void
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Title")){
                    TextField("Name", text: $name)
                }
                Section {
                    Button(action: addTypeAction){
                        HStack{
                            Spacer()
                            Text("Add")
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Add Type"), displayMode: .inline)
        }
    }
    
    func addTypeAction() {
        onComplete(name)
    }
    
}
