//
//  nano_challenge_1_notes_appApp.swift
//  nano challenge 1 notes app
//
//  Created by Harsha Vardhan on 16/11/22.
//
import SwiftUI

@main
struct SwiftUINotesAppCloneApp: App {
    
    @StateObject private var myNotes = MyNotes()
    
    var body: some Scene {
        WindowGroup {
            ContentView(myNotes: myNotes)
        }
    }
}
