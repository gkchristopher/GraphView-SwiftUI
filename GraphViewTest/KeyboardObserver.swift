//
//  KeyboardObserver.swift
//  GraphViewTest
//
//  Created by Christopher Moore on 2/5/20.
//  Copyright © 2020 Roving Mobile. All rights reserved.
//

import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    @Published private(set) var keyboardHeight: CGFloat = 0.0

    private var cancellable: AnyCancellable?

    let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }

    let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }

    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.keyboardHeight, on: self)
    }
}
