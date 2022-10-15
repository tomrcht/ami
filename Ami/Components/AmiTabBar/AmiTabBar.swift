//
//  AmiTabBar.swift
//  Ami
//
//  Created by Tom Rochat on 15/10/2022.
//

import SwiftUI

struct AmiTabBar: View {
    @Binding private var selection: Page
    @EnvironmentObject private var themeManager: ThemeManager

    init(selection: Binding<Page>) {
        self._selection = selection
    }

    var body: some View {
        HStack {
            Group {
                ForEach(Page.all) { page in
                    Item(
                        icon: Image(systemName: page.iconName),
                        name: page.name
                    )
                    .foregroundColor(selection.id == page.id ? themeManager.current.mainColor : .black)
                    .onTapGesture {
                        guard selection.id != page.id else { return }
                        selection = page
                    }
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 24)
        .frame(maxHeight: 56)
    }
}

extension AmiTabBar {
    struct Item: View {
        let icon: Image
        let name: String

        var body: some View {
            VStack(alignment: .center, spacing: 8) {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .font(.light(ofSize: 12))

                Text(name)
                    .font(.regular(ofSize: 12))
            }
        }
    }
}

struct AmiTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AmiTabBar(selection: .constant(.home))
            .environmentObject(ThemeManager())
    }
}
