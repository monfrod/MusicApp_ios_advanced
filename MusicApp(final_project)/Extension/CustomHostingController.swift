//
//  YourHostingController.swift
//  MusicApp(final_project)
//
//  Created by yunus on 03.05.2025.
//


import SwiftUI
import UIKit

class CustomHostingController <Content>: UIHostingController<AnyView> where Content : View {

  public init(shouldShowNavigationBar: Bool, rootView: Content) {
      super.init(rootView: AnyView(rootView.navigationBarHidden(!shouldShowNavigationBar)))
  }

  @objc required dynamic init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
