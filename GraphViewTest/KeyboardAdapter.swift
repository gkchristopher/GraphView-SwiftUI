//
//  KeyboardAdapter.swift
//  GraphViewTest
//
//  Created by Christopher Moore on 2/5/20.
//  Copyright © 2020 Roving Mobile. All rights reserved.
//

import Combine
import SwiftUI

struct KeyboardAdapter: ViewModifier {
    @State var currentHeight: CGFloat = 0.0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, self.currentHeight)
            .onAppear(perform: subscribeToKeyboardNotifications)
    }

    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }

    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }

    private func subscribeToKeyboardNotifications() {
        _ = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.currentHeight, on: self)
    }
}
