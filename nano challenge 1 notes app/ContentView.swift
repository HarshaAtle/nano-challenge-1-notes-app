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
    @State var newFolderName = ""
    var body: some View {
        ZStack {
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
               .textCase(nil)
            }
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
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.gray))
                    .frame(width: 200, height: 200, alignment: .center)
                VStack{
                    Text("New Folder")
                        .font(.headline)
                    Text("Enter a new name for this folder")
                        .font(.subheadline)
                    Spacer()
                    TextField("name", text: $newFolderName)
                        .frame(width: 200, height: 10)
                        .background(Color(.white))
                        .padding()
                        .cornerRadius(7)
                    Spacer()
                    Color.gray.frame(width: 200, height: CGFloat(1))
                    HStack {
                        Button(action: {print("cancel")}) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                        }
                        Button("Save"){
                            print("Cancel")
                        }
                    }
                }
            }
            .frame(width: 200, height: 200)
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
    

