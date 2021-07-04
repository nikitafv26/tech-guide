//
//  EquipmentView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 30.06.2021.
//

import SwiftUI

var equipments: [String: String] = [
    "V324MK": "опрыскиватель",
    "TRJ456/Y": "опрыскиватель",
    "QW211T": "комбайн",
    "B77745": "комбайн"
]

struct EquipmentListView: View {
    //@State private var isShowingEquipmentTypeListView = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity:
            Equipment.entity()
        ,
        sortDescriptors:[
            NSSortDescriptor(keyPath: \Equipment.name, ascending: true)
        ]
    ) var equipment: FetchedResults<Equipment>
    
    var body: some View {
        NavigationView {
            List{
                ForEach(equipments.sorted(by: >), id: \.key){(key, value) in
                    VStack(alignment: .leading){
                        Text(key)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text(value)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.subheadline)
                    }
                }
            }
            
            .navigationBarTitle(Text("Tech Guide"))
            .navigationBarItems(trailing: NavigationLink(
                                    destination: EquipmentAddView(),
                                    label: {
                                        Image(systemName: "plus")
                                    }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct EquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentListView()
    }
}
