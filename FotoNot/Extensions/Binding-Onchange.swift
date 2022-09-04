//
//  Binding-Onchange.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 3.09.2022.
//

import SwiftUI

extension Binding {
    func onChange(_ handle: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue},
            set: { newValue in
                self.wrappedValue = newValue
               handle()
            }
        )
    }
}
