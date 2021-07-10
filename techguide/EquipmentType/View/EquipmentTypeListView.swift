//
//  EquipmentTypeView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 27.06.2021.
//

import SwiftUI
import CoreData

struct EquipmentTypeListView: View {
    
    let typesTestData: [String] = [
        "Опрыскиватель", "Комбайн", "Посевной комплекс"
    ]
    
    @Binding var rootIsActive: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity:
            EquipmentType.entity(),
        sortDescriptors:[
            NSSortDescriptor(keyPath: \EquipmentType.name, ascending: true)
        ]
    ) var types: FetchedResults<EquipmentType>
    
    //@State var isPresented = false
    
    var body: some View {
        List{
            ForEach(types, id: \EquipmentType.id){ type in
                NavigationLink(
                    destination:
                        EquipmentAddView(
                            type: type.name ?? "",
                            popToRootView: self.$rootIsActive
                        ){ name in
                            print("added item \(name), type \(type.name ?? "")")
                            addEquipment(name: name, type: type)
                        },
                    label: {
                        EquipmentTypeCellView(type: type)
                    })
                    .isDetailLink(false)
            }
            //.onDelete(perform: deleteEquipmentType)
        }
        .navigationTitle(Text("Types"))
        .onAppear(){
            DispatchQueue.global().async {
                addTypesIfNotExists()
            }
        }
    }
    
    func addTypesIfNotExists()
    {
        if types.count == 0{
            for name in typesTestData{
                addEquipmentType(name: name)
            }
        }
    }
    
    func addEquipmentType(name: String){
        let type = EquipmentType(context: managedObjectContext)
        type.id = UUID()
        type.name = name
        
        saveContext()
    }
    
    func addEquipment(name: String, type: EquipmentType) {
        let eq = Equipment(context: managedObjectContext)
        eq.id = UUID()
        eq.name = name
        eq.equipmentType = type
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        }catch{
            fatalError("Error while saving managed object context \(error)")
        }
    }
}
