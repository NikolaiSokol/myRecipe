//
//  MultiSelectView.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import SwiftUI

struct MultiSelectView<SelectionValue>: View where SelectionValue: Hashable & Identifiable & Localizable {
    
    private let title: String?
    private let items: [SelectionValue]
    @Binding private var selections: Set<SelectionValue>
    
    init(
        title: String? = nil,
        items: [SelectionValue],
        selections: Binding<Set<SelectionValue>>
    ) {
        self.title = title
        self.items = items
        _selections = selections
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: UIConstants.Paddings.xs) {
                if let title {
                    Text(title)
                        .customFont(size: UIConstants.Font.l)
                        .fontWeight(.semibold)
                        .padding(.top, UIConstants.Paddings.xxs)
                }
                
                clearAllButton
                
                content
                
                Spacer()
                    .frame(height: UIConstants.Paddings.s)
            }
        }
        .padding(.top, UIConstants.Paddings.m)
    }
    
    private var content: some View {
        ForEach(items, id: \.id) { item in
            Button {
                didTapItem(item)
            } label: {
                itemRow(item)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var clearAllButton: some View {
        HStack {
            Spacer()
            
            Button(action: didTapClearAll) {
                Text(String(localized: .clearAll))
                    .customFont(size: UIConstants.Font.s)
                    .fontWeight(.semibold)
            }
            .disabled(selections.isEmpty)
        }
        .padding(.bottom, UIConstants.Paddings.xs)
    }
    
    private func itemRow(_ item: SelectionValue) -> some View {
        VStack(spacing: UIConstants.Paddings.xxs) {
            HStack {
                Text(item.localizedString())
                    .customFont(size: UIConstants.Font.m)
                
                Spacer()
                
                radioButton(isSelected: isSelected(item: item))
            }
            .contentShape(Rectangle())
            
            if !items.isLastItem(item) {
                Separator()
            }
        }
    }
    
    private func radioButton(isSelected: Bool) -> some View {
        Circle()
            .stroke(Color(.accentGray), lineWidth: 1)
            .frame(height: 25)
            .modifier(if: isSelected) {
                $0.overlay {
                    Circle()
                        .foregroundColor(Color(.primaryAccent))
                        .padding(UIConstants.Paddings.xxxs)
                }
            }
    }
    
    private func didTapItem(_ item: SelectionValue) {
        if isSelected(item: item) {
            selections.remove(item)
        } else {
            selections.insert(item)
        }
    }
    
    private func didTapClearAll() {
        selections.removeAll()
    }
    
    private func isSelected(item: SelectionValue) -> Bool {
        selections.contains(item)
    }
}

struct MultiSelectView_Previews: PreviewProvider {
    static var previews: some View {
        let items = IntoleranceType.allCases

        MultiSelectView(
            items: items,
            selections: .constant(Set<IntoleranceType>())
        )
    }
}
