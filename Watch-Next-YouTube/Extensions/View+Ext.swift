//
//  View+Ext.swift
//  Watch-Next-YouTube
//
//  Created by Mikolaj Lukasik on 02/06/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import SwiftUI

extension View {
    typealias ContentTransform<Content: View> = (Self) -> Content
    @ViewBuilder func conditionalModifier<TrueContent: View, FalseContent: View>(
          _ condition: Bool,
          ifTrue: ContentTransform<TrueContent>,
          ifFalse: ContentTransform<FalseContent>) -> some View {
      if condition {
        ifTrue(self)
      } else {
        ifFalse(self)
      }
    }
}
