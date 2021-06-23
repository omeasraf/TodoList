//
//  ListViewModel.swift
//  TodoList
//
//  Created by Ome Asraf on 6/23/21.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItem()
        }
    }
    @Published var completedCount:Int = 0;
    let itemsKey:String = "item_list"
    let completedKey:String = "completed_item_count"
    
    init() {
        getItems()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data),
            let cCount:Int = UserDefaults.standard.value(forKey: completedKey) as? Int
        else { return }
        
        self.items = savedItems
        self.completedCount = cCount
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
                    items.move(from: index, to: 0)
                }
                else{
                    if let firstIdx = items.firstIndex(where: {
                        $0.id != item.id && $0.isCompleted == true
                    }){
                        items.move(from: index, to: firstIdx)
                    }
                    else{
  
                        items.move(from: index, to: 0)
                    }
                }
            }
            else{
                if (completedCount > 0){
                    completedCount -= 1
                }
                if completedCount == 0 {
                    items.move(from: index, to: 0)
                }
                else{
                    if let firstIdx = items.firstIndex(where: {
                        $0.id != item.id && $0.isCompleted == false
                    }){
                        items.move(from: index, to: firstIdx != 0 ? firstIdx - 1 : firstIdx)
                    }
                    else{
                        items.move(from: index, to: items.endIndex - 1)
                     
                    }
                }
            }
        }
        saveItem()
        print("Completed: " + String(completedCount))
    }
    
    func saveItem() {
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
            UserDefaults.standard.set(completedCount, forKey: completedKey)
        }
    }
}


extension Array where Element: Equatable
{
    mutating func move(_ element: Element, to newIndex: Index) {
        if let oldIndex: Int = self.firstIndex(of: element) { self.move(from: oldIndex, to: newIndex) }
    }
}

extension Array
{
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}
