//
//  CreativeBordersView.swift
//  Shapes
//
//  Created by Ivan Pryhara on 10.03.23.
//

import Foundation
import SwiftUI

struct CreateBordersView: View {
    var body: some View {
        Text("Hi world")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image("BorderExample"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 50)
    }
}


struct CreateBordersView_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateBordersView()
    }
}
