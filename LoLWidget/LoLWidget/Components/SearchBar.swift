//
//  SearchBar.swift
//  LoLWidget
//
//  Created by JK on 2022/02/03.
//

import SwiftUI

struct SearchBar: View {
    let placeHolder: String
    @Binding var text: String
    @State private(set) var isEditing = false

    var body: some View {
        HStack {
            TextField(placeHolder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onTapGesture {
                    self.isEditing = true
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }

    }

}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(placeHolder: "Search ...", text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
