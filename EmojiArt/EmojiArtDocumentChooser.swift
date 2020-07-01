//
//  EmojiArtDocumentChooser.swift
//  EmojiArt
//
//  Created by H Hugo Falkman on 30/06/2020.
//  Copyright © 2020 H Hugo Falkman. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentChooser: View {
    @EnvironmentObject var store: EmojiArtDocumentStore
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.documents) { document in
                    NavigationLink(destination: EmojiArtDocumentView(document: document)
                        .navigationBarTitle(self.store.name(for: document))
                    ) {
                        EditableText(self.store.name(for: document), isEditing: self.editMode.isEditing) { name in
                            self.store.setName(name, for: document)
                        }
                    }
                }
                    .onDelete { indexSet in
                        indexSet.map { self.store.documents[$0] }.forEach { document in
                            self.store.removeDocument(document)
                        }
                    }
            }
                .navigationBarTitle(store.name)
                .navigationBarItems(
                    leading: Button(action: {
                        self.store.addDocument()
                    }, label: {
                        Image(systemName: "plus").imageScale(.large)
                    }),
                    trailing: EditButton()
                )
                .environment(\.editMode, $editMode)
        }
    }
}

struct EmojiArtDocumentChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentChooser()
    }
}
