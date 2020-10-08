//
//  SmallWidgetView.swift
//  KahootWidgetExtension
//
//  Created by Frank Bara on 10/7/20.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    
    let discoverGroup: DiscoverGroup
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geometryProxy in
                discoverGroup.coverImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
                    .clipped()
                    .numberOfQuestions(discoverGroup.numberOfQuestions)
            }
            VStack(alignment: .leading) {
                Text(discoverGroup.groupTitle)
                    .font(.custom("Montserrat", size: 11, relativeTo: .title))
                    .bold()
                    .foregroundColor(Color("Gray4"))
                    .textCase(.uppercase)
                    .lineLimit(1)
                Text(discoverGroup.cardTitle)
                    .font(.custom("Montserrat", size: 12, relativeTo: .body))
                    .bold()
                    .foregroundColor(Color("Gray5"))
                    .lineLimit(2)
            }
            .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
        }
        .background(Color("SmallWidgetBackground"))
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        
        let discoverGroup = DiscoverGroup(cardTitle: "World Architecture", coverImage: Image("DummyImage"), creatorAvatarImage: nil, creatorUsername: "Frank B.", groupTitle: "Top Picks", numberOfQuestions: 6)
        
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            SmallWidgetView(discoverGroup: discoverGroup)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, colorScheme)
                .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
        }
    }
}
