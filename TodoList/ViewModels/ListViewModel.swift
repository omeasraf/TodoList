//
//  ListViewModel.swift
//  TodoList
//
//  Created by Ome Asraf on 6/23/21.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var completedCount:Int = 0;
    
    init() {
        getItems()
    }
    
    func getItems(){
        let newItems = [
            ItemModel(title: "Hello World", isCompleted: false),
            ItemModel(title: "Second Item", isCompleted: false),
            ItemModel(title: "Third World", isCompleted: false)
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateCompletion()
            
            if items[index].isCompleted {
                completedCount += 1
                if completedCount == 1 {
                    items.swapAt(index, 0)
                }
                else{
                    if let firstIdx = items.firstIndex(where: {
                        $0.isCompleted == true
                    }){
                        items.swapAt(index, firstIdx)
                    }
                }
            }
            else{
                completedCount -= 1
                if completedCount == 0 {
                    items.swapAt(index, 0)
                }
                else{
                    if let firstIdx = items.firstIndex(where: {
                        $0.id != item.id && $0.isCompleted == false
                    }){
                        items.swapAt(index, firstIdx != 0 ? firstIdx - 1 : firstIdx)
                    }
                    else{
                        items.swapAt(index, items.endIndex - 1)
                    }
                }
            }
        }
    }
}
