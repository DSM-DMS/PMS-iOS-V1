//
//  studentCodeView.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/10.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI
import Foundation

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct PassCodeInputField: View {
    
    @ObservedObject var inputModel: studentCodeModel
    
    var body: some View {
        HStack {
            ForEach(0 ..< self.inputModel.numberOfCells) { index in
                VStack(spacing: 0) {
                    PassCodeInputCell(index: index, selectedCellIndex: self.$inputModel.selectedCellIndex, textReference: self.$inputModel.passCode[index])
                        .frame(width: 20, height: 20, alignment: .center)
//                        .foregroundColor(index == self.inputModel.selectedCellIndex ? .blue : .black)
                        .padding([.trailing, .leading], 10)
                        .padding([.vertical], 10)
                    
                    if self.inputModel.selectedCellIndex == index {
                        Color.blue.frame(width: 30, height: 1)
                    } else {
                        Color.black.frame(width: 30, height: 1)
                    }
                    
                }
            }
        }
    }
}

struct PassCodeInputField_Previews: PreviewProvider {
    static var previews: some View {
        PassCodeInputField(inputModel: studentCodeModel(passCodeLength: 6))
    }
}

protocol CharacterFieldBackspaceDelegate: class {
    /**
     - Parameter textField: A CharacterField instance
     */
    func charFieldWillDeleteBackward(_ textField: CharacterField)
}

class CharacterField: UITextField {
    public weak var willDeleteBackwardDelegate: CharacterFieldBackspaceDelegate?
    
    override func deleteBackward() {
        willDeleteBackwardDelegate?.charFieldWillDeleteBackward(self)
        super.deleteBackward()
    }
    
}

struct PassCodeInputCell: UIViewRepresentable {
    
    typealias UIViewType = CharacterField
    
    // No one else should change this
    var index: Int
    
    // Bound from a PassCodeInputModel instance
    @Binding var selectedCellIndex: Int
    @Binding var textReference: String
    
    func makeUIView(context: UIViewRepresentableContext<PassCodeInputCell>) -> CharacterField {
        
        let charField = CharacterField(frame: .zero)
        charField.textAlignment = .center
        
        // Caps and suggestions don't make sense
        charField.autocapitalizationType = .none
        charField.autocorrectionType = .no
        
        charField.delegate = context.coordinator
        charField.willDeleteBackwardDelegate = context.coordinator
        
        charField.keyboardType = .decimalPad
        charField.addDoneCancelToolbar()

        return charField
    }

    func updateUIView(_ uiView: CharacterField,
                      context: UIViewRepresentableContext<PassCodeInputCell>) {
        if index == selectedCellIndex {
            uiView.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(index: index, selectedCellIndex: self.$selectedCellIndex, textReference: self.$textReference)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate, CharacterFieldBackspaceDelegate {
        
        // No one else should change this
        var index: Int
        // Each cell will update this
        @Binding var selectedCellIndex: Int
        // Reference to an index in the text array
        // from a PassCodeInputModel instance
        @Binding var textReference: String
        
        /**
         - Parameter index: Index of this cell in the pass code array
         - Parameter selectedCellIndex: index of where the user is upto
         - Parameter textReference: reference in the array to update input
         */
        init(index: Int, selectedCellIndex: Binding<Int>,
             textReference: Binding<String>) {
            // The underscore thing is important due to
            // the Binding<T> syntax
            _selectedCellIndex = selectedCellIndex
            _textReference = textReference
            self.index = index
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            let currentText = textField.text ?? "" // textField.text? will almost assuredly never be nil, but we should always assume it could be
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // Increment the index if the change was on char
            if updatedText.count == 1 {
                self.selectedCellIndex += 1
            }
            
            // Stop input if there's more than one character
            return updatedText.count <= 1
            
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.textReference = textField.text ?? ""
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            self.selectedCellIndex = self.index
            return true
        }
        
        func charFieldWillDeleteBackward(_ textField: CharacterField) {
            if textField.text == "" && selectedCellIndex > 0 {
                self.selectedCellIndex -= 1
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder()  }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
}
