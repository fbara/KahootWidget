//
//  HeaderView.swift
//  KahootWidgetExtension
//
//  Created by Frank Bara on 10/7/20.
//

import SwiftUI
import WidgetKit

struct HeaderView: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image("DiscoverGroupIcon")
                .unredacted()
            Text(self.title)
                .font(.custom("Montserrat", size: 11, relativeTo: .headline))
                .bold()
                .lineLimit(2)
                .textCase(.uppercase)
            
            Spacer()
            
            Image("K!Logo")
                .unredacted()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Top Picks")
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
