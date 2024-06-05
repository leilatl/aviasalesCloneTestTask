//
//  EmptyView.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 31.05.2024.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Text("Empty View")
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
            Spacer()
        }
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
