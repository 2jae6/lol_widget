//
//  LabelAndText.swift
//  LoLWidget
//
//  Created by JK on 2022/02/03.
//

import SwiftUI

struct LabelAndText<Content>: View where Content: View {
    init(label: String, innerView: Content) {
        self.label = label
        self.innerView = innerView
    }

    init(label: String, innerBlock: () -> Content) {
        self.label = label
        innerView = innerBlock()
    }

    var body: some View {
        HStack {
            Text(label)
                .font(.title2)
                .fontWeight(.bold)

            innerView
        }
    }

    private let label: String
    private let innerView: Content
}
