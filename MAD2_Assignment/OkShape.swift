//
//  OkShape.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 1/2/21.
//

import Foundation
import SwiftUI

struct OkShape: Shape {
         
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: rect.origin.x, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.origin.y))
        }
    }
}
