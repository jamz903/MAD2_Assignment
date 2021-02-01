//
//  WidgetUI.swift
//  MAD2_Assignment
//
//  Created by Shane-Rhys Chua on 1/2/21.
//

import Foundation
import SwiftUI
import WidgetKit

@available(iOS 14, *)
struct PrimaryItem {
    @AppStorage("Service", store: UserDefaults(suiteName: "group.sg.justin.MAD2-Assignment")) var primaryItemData: Data = Data()
    
    let primaryItem : Service
    
    func storeItem(){
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(primaryItem) else{
            print("could not encode data")
            return
        }
        
        primaryItemData = data
        WidgetCenter.shared.reloadAllTimelines()
        print(String(decoding: primaryItemData, as: UTF8.self))
    }
}
