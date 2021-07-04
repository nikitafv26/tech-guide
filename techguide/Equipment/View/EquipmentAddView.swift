//
//  EquipmentTypeView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 27.06.2021.
//

import SwiftUI
import CoreData

struct EquipmentAddView: View {
    
    let typesTestData: [String] = [
        "Опрыскиватель", "Комбайн", "Посевной комплекс"
    ]
    
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
                        EquipmentAddInfoView(type: type.name ?? ""){ name in
                            print(name)
                            //addEquipment(name: name, type: type)
                        },
                    label: {
                        EquipmentTypeCellView(type: type)
                    })
            }
            .onDelete(perform: deleteEquipmentType)
        }
        .navigationTitle(Text("Types"))
        .onAppear(){
            DispatchQueue.global().async {
                addTypesIfNotExists()
            }
        }
        
        //.sheet(isPresented: $isPresented){
        //            EquipmentTypeAddView {(name: String) in
        //                self.addEquipmentType(name: name)
        //                self.isPresented = false
        //            }
        //}
    }
    
    func addTypesIfNotExists()
    {
        if types.count == 0{
            for name in typesTestData{
                addEquipmentType(name: name)
            }
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

struct EquipmentTypeView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentAddView()
    }
}


//struct EquipmentTypeAddView: View {
//
//    @State var name = ""
//
//    let onComplete: (String) -> Void
//
//    var body: some View {
//        NavigationView{
//            Form {
//                Section(header: Text("Title")){
//                    TextField("Name", text: $name)
//                }
//                Section {
//                    Button(action: addTypeAction){
//                        HStack{
//                            Spacer()
//                            Text("Add")
//                            Spacer()
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle(Text("Add Type"), displayMode: .inline)
//        }
//    }
//
//    func addTypeAction() {
//        onComplete(name)
//    }
//
//}
