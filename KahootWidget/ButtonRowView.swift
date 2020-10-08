//
//  ButtonRowView.swift
//  KahootWidgetExtension
//
//  Created by Frank Bara on 10/7/20.
//

import SwiftUI
import WidgetKit

struct LinkButtonView: View {
    let imageName: String
    var shadow: Bool = false
    let text: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .shadow(radius: self.shadow ? 4 : 0)
            
            Text(text)
                .font(.custom("Montserrat", size: 12, relativeTo: .title))
                .bold()
                .foregroundColor(Color("Gray4"))
        }
    }
}

struct ButtonRowView: View {
    var body: some View {
        HStack(alignment: .top) {
            LinkButtonView(imageName: "Search", text: "Search")
            Spacer()
            LinkButtonView(imageName: "EnterPIN", shadow: true, text: "EnterPIN")
            Spacer()
            LinkButtonView(imageName: "Create", text: "Create")
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

struct ButtonRowView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ButtonRowView()
                .background(Color("MediumAndLargeWidgetBackground"))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
                .environment(\.colorScheme, colorScheme)
                .previewDisplayName("\(colorScheme)")
        }
    }
}
