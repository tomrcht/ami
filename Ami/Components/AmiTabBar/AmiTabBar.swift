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
                    let isSelected = selection.id == page.id

                    ZStack(alignment: .bottom) {
                        if isSelected {
                            Circle()
                                .fill(themeManager.current.primary)
                                .frame(width: 8, height: 8)
                                .padding(.bottom, 8)
                        }

                        Item(
                            icon: Image(systemName: page.iconName),
                            name: page.name,
                            isSelected: isSelected
                        )
                        .onTapGesture {
                            guard selection.id != page.id else { return }
                            withAnimation {
                                selection = page
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: themeManager.current.text.opacity(0.2), radius: 3, x: 0, y: 0)
        .frame(maxHeight: 56)
    }
}

extension AmiTabBar {
    struct Item: View {
        let icon: Image
        let name: String
        let isSelected: Bool

        var body: some View {
            VStack(alignment: .center, spacing: 8) {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .font(.light(ofSize: 12))

                Text(name)
                    .font(.regular(ofSize: 12))
                    .opacity(isSelected ? 0 : 1)
            }
        }
    }
}

struct AmiTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AmiTabBar(selection: .constant(.home))
            .environmentObject(ThemeManager())
            .padding(24)
    }
}
