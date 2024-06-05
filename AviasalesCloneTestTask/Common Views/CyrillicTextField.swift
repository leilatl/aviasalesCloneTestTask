//
//  CyrillicTextField.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import SwiftUI

struct CyrillicTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    var onActivate: (() -> Void)? = nil
    var onEnter: (() -> Void)? = nil

    func makeCoordinator() -> TextFieldCoordinator {
        return TextFieldCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.delegate = context.coordinator
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(Color.theme.grey6),
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

class TextFieldCoordinator: NSObject, UITextFieldDelegate {
    var parent: CyrillicTextField

    init(parent: CyrillicTextField) {
        self.parent = parent
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let filteredText = newText.filterCyrillic()
        textField.text = filteredText
        parent.text = filteredText
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        parent.onActivate?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parent.onEnter?()
        textField.resignFirstResponder()
        return true
    }
}
