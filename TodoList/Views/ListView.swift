//
//  ListView.swift
//  TodoList
//
//  Created by Ome Asraf on 6/23/21.
//

import SwiftUI
import SFIcons


struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        

        List{
            if listViewModel.items.isEmpty{
                Text("Please add an item to your TodoList 😉")
            }
            else{
            ForEach(listViewModel.items){item in
                ListRowView(item: item)
                    .onTapGesture {
                        withAnimation(.linear){
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
            }
        
        }

        .listStyle(SidebarListStyle())
        .navigationTitle("TodoList 📝")
        .navigationBarItems(leading: EditButton(),
                            trailing: NavigationLink("Add", destination: AddView()))
        
    }
    

}




struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

