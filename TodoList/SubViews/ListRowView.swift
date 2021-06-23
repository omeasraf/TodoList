//
//  ListRowView.swift
//  TodoList
//
//  Created by Ome Asraf on 6/23/21.
//

import SwiftUI
import SFIcons

struct ListRowView: View {
    let item: ItemModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? SFIcons.checkmarkCircle : SFIcons.circle)
                .foregroundColor(item.isCompleted ? Color.green : Color.red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(title: "First Item", isCompleted: false)
    static var item2 = ItemModel(title: "Second Item", isCompleted: true)
    static var previews: some View {
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
