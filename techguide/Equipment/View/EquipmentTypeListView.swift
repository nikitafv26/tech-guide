//
//  EquipmentTypeView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 27.06.2021.
//

import SwiftUI
import CoreData

struct EquipmentTypeListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity:
            EquipmentType.entity(),
        sortDescriptors:[
            NSSortDescriptor(keyPath: \EquipmentType.name, ascending: true)
        ]
    ) var types: FetchedResults<EquipmentType>
    
    @State var isPresented = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(types, id: \EquipmentType.name){
                    EquipmentTypeCellView(type: $0)
                }
                .onDelete(perform: deleteEquipmentType)
            }
            .sheet(isPresented: $isPresented){
                EquipmentTypeAddView {(name: String) in
                    self.addEquipmentType(name: name)
                    self.isPresented = false
                }
            }
            .navigationBarTitle(Text("TechGuide"))
            .navigationBarItems(trailing: Button(action: {self.isPresented.toggle()}){
                Image(systemName: "plus")
            })
        }
    }
    
    func deleteEquipmentType(at offsets: IndexSet){
        offsets.forEach{ index in
            let type = self.types[index]
            self.managedObjectContext.delete(type)
            
            saveContext()
        }
    }
    
    func addEquipmentType(name: String){
        let type = EquipmentType(context: managedObjectContext)
        
        type.name = name
        
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

struct EquipmentTypeView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentTypeListView()
    }
}
