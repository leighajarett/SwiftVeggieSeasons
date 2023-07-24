//
//  DetailLabelView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/24/23.
//

import SwiftUI

struct DetailLabel: View {
    let label: String
    let value: String

    var body: some View{
        HStack{
            Text(label)
            Text(value)
                .frame(maxWidth: .infinity,
                       alignment:.trailing)
                .foregroundColor(Color.secondary)
        }
    }

}
