//
//  LargeWidgetView.swift
//  KahootWidgetExtension
//
//  Created by Frank Bara on 10/7/20.
//

import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    let discoverGroup: DiscoverGroup
    
    var body: some View {
        VStack {
            HeaderView(title: discoverGroup.groupTitle)

            
            VStack(alignment: .leading) {
                
                GeometryReader { geometryProxy in
                    discoverGroup.coverImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
                        .clipped()
                        .numberOfQuestions(discoverGroup.numberOfQuestions)
                }
                
                VStack(alignment: .leading) {
                    Text(discoverGroup.cardTitle)
                        .font(.custom("Montserrat", size: 14, relativeTo: .title))
                        .bold()
                        .foregroundColor(Color("Gray5"))
                        .lineLimit(2)
                    
                    HStack {
                        Group {
                            if let creatorAvatarImage = discoverGroup.creatorAvatarImage {
                                creatorAvatarImage
                                    .resizable()
                            } else {
                                Image("CreatorAvatarMissing")
                                    .unredacted()
                            }
                        }
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        
                        Text(discoverGroup.creatorUsername)
                            .font(.custom("Montserrat", size: 14, relativeTo: .title))
                            .bold()
                            .lineLimit(1)
                            .foregroundColor(Color("Gray4"))
                    }
                }
                .padding(8)
            }
            .background(Color("CardBackground"))
            .cornerRadius(4)
                
            ButtonRowView()
                .unredacted()
        }
        .padding()
        .background(Color("MediumAndLargeWidgetBackground"))
    }
}

struct LargeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let discoverGroup = DiscoverGroup(cardTitle: "World Architecture", coverImage: Image("DummyImage"), creatorAvatarImage: nil, creatorUsername: "Frank B.", groupTitle: "Top Picks", numberOfQuestions: 6)
        
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            LargeWidgetView(discoverGroup: discoverGroup)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
                .environment(\.colorScheme, colorScheme)
                .previewDisplayName("\(colorScheme)")
                .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
        }
    }
}
