//
//  MediumWidgetView.swift
//  KahootWidgetExtension
//
//  Created by Frank Bara on 10/7/20.
//

import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    
    let discoverGroup: DiscoverGroup
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Image("DiscoverGroupIcon")
                Text(discoverGroup.groupTitle)
                    .font(.custom("Montserrat", size: 11, relativeTo: .headline))
                    .bold()
                    .lineLimit(2)
                    .textCase(.uppercase)
                
                Spacer()
                
                Image("K!Logo")
            }
            
            GeometryReader { geometryProxy in
                HStack {
                    discoverGroup.coverImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometryProxy.size.width/3, height: geometryProxy.size.height)
                        .clipped()
                        .numberOfQuestions(discoverGroup.numberOfQuestions)
                    
                    VStack(alignment: .leading) {
                        Text(discoverGroup.cardTitle)
                            .font(.custom("Montserrat", size: 14, relativeTo: .title))
                            .bold()
                            .foregroundColor(Color("Gray5"))
                            .lineLimit(2)
                        
                        Spacer()
                        
                        Text(discoverGroup.creatorUsername)
                            .font(.custom("Montserrat", size: 14, relativeTo: .title))
                            .bold()
                            .lineLimit(1)
                            .foregroundColor(Color("Gray4"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                }
                .background(Color("CardBackground"))
                .cornerRadius(4)
                
            }
                
        }
        .padding()
        .background(Color("MediumAndLargeWidgetBackground"))
    }
}

struct MediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        
        let discoverGroup = DiscoverGroup(cardTitle: "World Architecture", coverImage: Image("DummyImage"), creatorAvatarImage: nil, creatorUsername: "Frank B.", groupTitle: "Top Picks", numberOfQuestions: 6)
        
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            MediumWidgetView(discoverGroup: discoverGroup)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.colorScheme, colorScheme)
        }
    }
}