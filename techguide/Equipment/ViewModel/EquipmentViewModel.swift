//
//  EquipmentViewModel.swift
//  techguide
//
//  Created by Nikita Fedorenko on 12.07.2021.
//

import Foundation
import Combine

class EquipmentViewModel: ObservableObject {
    @Published var equipments: [Equipment] = []
    
    private var cancellable: AnyCancellable?
    
    init(equipmentPublisher: AnyPublisher<[Equipment], Never> =
            EquipmentRepository.shared.equipments.eraseToAnyPublisher()){
        cancellable = equipmentPublisher.sink(receiveValue: {equipments in
            NSLog("Updating equipments")
            self.equipments = equipments
        })
    }
    
    func delete(id: Int) {
        EquipmentRepository.shared.delete(id: id)
    }
}
