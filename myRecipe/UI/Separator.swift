//
//  Separator.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.02.2023.
//

import SwiftUI

struct Separator: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(.separator))
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
}

struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        Separator()
    }
}
