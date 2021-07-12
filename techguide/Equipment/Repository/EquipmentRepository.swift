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
    
    var equipments = CurrentValueSubject<[Equipment], Never>([])
    private let equipmentFetchController: NSFetchedResultsController<Equipment>
    
    static let shared = EquipmentRepository()
    
    public override init() {
        equipmentFetchController = NSFetchedResultsController(
            fetchRequest: Equipment.fetchRequest(),
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
    
    func delete(){
        
    }
}

extension EquipmentRepository: NSFetchedResultsControllerDelegate{
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let equipments = controller.fetchedObjects as? [Equipment] else { return }
        NSLog("Context has changed, reloading equipments")
        self.equipments.value = equipments
    }
}
