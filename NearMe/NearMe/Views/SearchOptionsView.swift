//
//  SearchOptionsView.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/20/23.
//

import SwiftUI

struct SearchOptionsView: View {
    
    let searchOptions = ["Restaurants": "fork.knife", "Hotels": "bed.double.fill", "Coffee": "cup.and.saucer.fill", "Gas": "fuelpump.fill"]
    
    let onSelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(searchOptions.sorted(by: >), id: \.0) { key, value in
                    Button(action: {
                        onSelected(key)
                    }, label: {
                        HStack {
                            Image(systemName: value)
                            Text(key)
                        }
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    SearchOptionsView { _ in
        
    }
}
