//
//  EquipmentTypeDetailView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 03.07.2021.
//

import SwiftUI

struct EquipmentAddInfoView: View {
    
    var type: String
    @State var name: String = ""
    
    let onComplete: (String) -> Void
    
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
    }
    
    func addEquipment(){
        onComplete(name)
    }
}
