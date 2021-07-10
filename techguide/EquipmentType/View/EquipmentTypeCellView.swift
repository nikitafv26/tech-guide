//
//  EquipmentTypeCellView.swift
//  techguide
//
//  Created by Nikita Fedorenko on 27.06.2021.
//

import SwiftUI

struct EquipmentTypeCellView: View {
    let type: EquipmentType
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                type.name.map(Text.init)
                    .font(.title)
            }
        }
    }
}

//struct EquipmentTypeCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        EquipmentTypeCellView()
//    }
//}
