//
//  EquipmentView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 30.06.2021.
//

import SwiftUI

//var equipments: [String: String] = [
//    "V324MK": "опрыскиватель",
//    "TRJ456/Y": "опрыскиватель",
//    "QW211T": "комбайн",
//    "B77745": "комбайн"
//]

struct EquipmentListView: View {
    
    @State var isActive: Bool = false
    @StateObject private var viewModel = EquipmentViewModel()
    
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(
//        entity:
//            Equipment.entity()
//        ,
//        sortDescriptors:[
//            NSSortDescriptor(keyPath: \Equipment.name, ascending: true)
//        ]
//    ) var equipments: FetchedResults<Equipment>
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(
                    destination: EquipmentTypeListView(rootIsActive: self.$isActive),
                    isActive: self.$isActive){EmptyView()}
                    .isDetailLink(false)
                
                List{
                    ForEach(viewModel.equipments, id: \Equipment.id){ eq in
                        VStack(alignment: .leading){
                            eq.name.map(Text.init)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            eq.equipmentType!.name.map(Text.init)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: deleteEquipment)
                }
            }
            
            .navigationBarTitle(Text("Tech Guide"))
            .navigationBarItems(trailing: Button(action: {self.isActive.toggle()}, label: {
                Image(systemName: "plus")
            })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
//    func saveContext(){
//        do{
//            try managedObjectContext.save()
//        }catch{
//            print("Error while saving managed objec context \(error)")
//        }
//    }
 
    func deleteEquipment(at indexSet: IndexSet) {
        indexSet.forEach { index in
            viewModel.delete(id: index)
        }
    }
    
}

struct EquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentListView()
    }
}
