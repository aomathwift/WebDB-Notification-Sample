//
//  KeyboardObserver.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0.0

    func startObserve() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil
        )
    }

    func stopObserve() {
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil
        )
    }

    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let keyboardBeginFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
                return
        }
        let endMinY = keyboardEndFrame.cgRectValue.minY
        let beginMinY = keyboardBeginFrame.cgRectValue.minY
        keyboardHeight = beginMinY - endMinY
        if keyboardHeight < 0 {
            keyboardHeight = 0
        }
    }
}
