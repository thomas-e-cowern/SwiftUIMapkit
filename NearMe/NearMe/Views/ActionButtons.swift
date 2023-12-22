//
//  ActionButtons.swift
//  NearMe
//
//  Created by Thomas Cowern on 12/22/23.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
    
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            if let phone = mapItem.phoneNumber {
                Button(action: {
                    let numericPhoneNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    makePhoneCall(phoneNumber: numericPhoneNumber)
                }, label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Call")
                    }
                })
                .buttonStyle(.bordered)
                .foregroundColor(.red)
            }
            
            Button(action: {
                MKMapItem.openMaps(with: [mapItem])
            }, label: {
                HStack {
                    Image(systemName: "car.circle.fill")
                    Text("Take me there")
                }
            })
            .buttonStyle(.bordered)
            .foregroundColor(.green)
            
            Spacer()
        }
    }
}

#Preview {
    ActionButtons(mapItem: PreviewData.apple)
}
