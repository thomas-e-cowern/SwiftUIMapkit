//
//  SearchBarView.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/20/23.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var search: String
    @Binding var isSearching: Bool
    
    var body: some View {
        VStack (spacing: -10){
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    // Will initiate search
                    isSearching = true
                }
            
            SearchOptionsView { searchTerm in
                search = searchTerm
                isSearching = true
            }
            .padding()
        }
    }
}

#Preview {
    SearchBarView(search: .constant("Coffee"), isSearching: .constant(true))
}
