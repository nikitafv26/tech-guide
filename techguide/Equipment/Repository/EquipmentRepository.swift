//
//  EquipmentRepository.swift
//  techguide
//
//  Created by Nikita Fedorenko on 12.07.2021.
//

import Foundation
import CoreData
import Combine

class EquipmentRepository: NSObject, ObservableObject {
    
    //publisher
    var equipments = CurrentValueSubject<[Equipment], Never>([])
    private let equipmentFetchController: NSFetchedResultsController<Equipment>
    
    static let shared = EquipmentRepository()
    
    public override init() {
        
        let fetchRequest = NSFetchRequest<Equipment>(entityName: "Equipment")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Equipment.name, ascending: true)]
        
        equipmentFetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: Persistence.shared.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        super.init()
        
        equipmentFetchController.delegate = self
        
        do{
            try equipmentFetchController.performFetch()
            equipments.value = equipmentFetchController.fetchedObjects ?? []
        }catch{
            NSLog("Error: could not fetch objects")
        }
    }
    
    func add(){
        
    }
    
    func update(){
        
    }
    
    func delete(id withId: Int){
        do{
            let eq = equipments.value[withId]
            equipmentFetchController.managedObjectContext.delete(eq)
            try equipmentFetchController.managedObjectContext.save()
        }catch{
            NSLog("Error while removing equipment \(error)")
        }
        
    }
}

extension EquipmentRepository: NSFetchedResultsControllerDelegate{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let equipments = controller.fetchedObjects as? [Equipment] else { return }
        NSLog("Context has changed, reloading equipments")
        self.equipments.value = equipments
    }
}
