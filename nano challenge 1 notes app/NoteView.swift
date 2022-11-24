//
//  NoteView.swift
//  nano challenge 1 notes app
//
//  Created by Harsha Vardhan on 22/11/22.
//

import SwiftUI

struct NoteView: View {
    @ObservedObject var myNotes: MyNotes
    @State var title = "BreakingBad"
    @State var noteText = "A high school chemistry teacher dying of cancer teams with a former student to secure his family's future by manufacturing and selling crystal meth and the legend name is Heisenberg!"
    @Environment(\.dismiss) var dismiss
    @State var newNoteName = ""
    @State var newTitle = ""
    
    
    var body: some View {
        //TextEditor(text: $noteText)
        TextView(text: $noteText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        myNotes.notes
                            .append(Note(title: newTitle))
                        dismiss()
               
                    }
                }
            }
    }
}


struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    let textStorage = NSTextStorage()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let attrs =
        [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: text, attributes: attrs)
        textStorage.append(attrString)
        
        let layoutManager = NSLayoutManager()
        let container = NSTextContainer(size: CGSize())
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        let textView = UITextView(frame: CGRect(), textContainer: container)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        context.coordinator.updateAttributedString()
        //uiView.attributedText = context.coordinator.updateAttributedString()
    }

    
    class Coordinator: NSObject {
        var parent: TextView
        
        var replacements: [String: [NSAttributedString.Key:Any]] = [:]
        
        init(_ textView: TextView) {
            self.parent = textView
            super.init()
            let strikeThroughAttributes = [NSAttributedString.Key.strikethroughStyle: 1]
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
            var descriptorWithTrait = fontDescriptor.withSymbolicTraits(.traitBold)
            
            var font = UIFont(descriptor: descriptorWithTrait!, size: 0)
            let boldAttributes = [NSAttributedString.Key.font:font]
            
            descriptorWithTrait = fontDescriptor.withSymbolicTraits(.traitBold)
            
            font = UIFont(descriptor: descriptorWithTrait!, size: 0)
            
            let italicAttributes = [ NSAttributedString.Key.font:font]
            let underlineAttributes = [NSAttributedString.Key.underlineStyle: 1]
            //boldAttributes = [NSAttributedString.Key.font:font]
            
            replacements = ["(-\\w+(\\s\\w+)*-)":strikeThroughAttributes,
                            "(#b\\w+(\\s\\w+)*#b)":strikeThroughAttributes,
                            "(#u\\w+(\\s\\w+)*#u)":strikeThroughAttributes,
                            "(#i\\w+(\\s\\w+)*#i)":strikeThroughAttributes]
        }
        
        //@7:58 3rd video
        func updateAttributedString() {
            for (pattern, attributes) in replacements {
                do {
                    let regex = try NSRegularExpression(pattern: pattern)
                    
                    let range = NSRange(parent.text.startIndex..., in: parent.text)
                    regex.enumerateMatches(in: parent.text, range: range){
                        match, flags, stop in
                        
                        if let matchRange = match?.range(at: 1) {
                            print("matched \(pattern)")
                            parent.textStorage.addAttributes(attributes, range: matchRange)
                        }
                    }
                } catch {
                    print("error occurred")
                }
            }
        }
    }
    
    typealias UIViewType = UITextView
    
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let testNotes = MyNotes()
        NoteView(myNotes: testNotes)
    }
}

