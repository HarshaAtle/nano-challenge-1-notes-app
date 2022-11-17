//
//  ContentView.swift
//  nano challenge 1 notes app
//
//  Created by Harsha Vardhan on 16/11/22.
//

import SwiftUI

struct ContentView: View {
    var folders = ["Folder1","Folder2"]
    @State var searchString = ""
    var body: some View {
        NavigationView(){
            List {
                TextField("Search", text: $searchString)
                Section(header:
                            Text("iCloud")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)) {
                        ForEach(folders, id: \.self){ folderName in
                            FolderCell(name: folderName)
                        }
                    }
                
            }    .textCase(nil)
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("folders")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button("Edit"){
                                print("Edit")
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar){
                        Image(systemName: "folder.badge.plus")
                        Image(systemName: "sqaure.and.pencil")
                    }
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct FolderCell: View {
        var name: String
        var body: some View {
            HStack {
                Image(systemName: "folder")
                Text(name)
            }
        }
    }
    

