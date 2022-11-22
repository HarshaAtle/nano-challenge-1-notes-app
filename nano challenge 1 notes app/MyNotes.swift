//
//  MyNotes.swift
//  nano challenge 1 notes app
//
//  Created by Harsha Vardhan on 18/11/22.
//

import Foundation

class MyNotes: ObservableObject {
    @Published var folders = [Folder]()
}

struct Folder: Identifiable {
    var id = UUID()
    
    var name: String
    var notes: [Note] = testNotes
}

struct Note: Identifiable {
    var id = UUID()
    var title: String
    var noteText: String = ""
}

var testFolders = [

    Folder(name: "Folder 01"),
    Folder(name: "Folder 02")
]

var testNotes = [
    Note(title: "Notes1"),
    Note(title: "Notes2")
]
