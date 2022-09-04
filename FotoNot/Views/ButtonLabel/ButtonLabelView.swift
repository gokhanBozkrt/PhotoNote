//
//  ButtonLabelView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 4.06.2022.
//

import SwiftUI

struct ButtonLabelView: View {
    let systemImageName: String
    let textName: String
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
            Text(textName)
        }
        .font(.headline)
        .padding()
        .frame(height: 48)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(15)
    }
}

