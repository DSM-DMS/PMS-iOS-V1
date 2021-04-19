//
//  studentCodeModel.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/10.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class studentCodeModel: ObservableObject {
    
    @Published var passCode: [String]
    @Published var isValid: Bool = false
    
    @Published var selectedCellIndex: Int {
        didSet {
            if selectedCellIndex >= self.numberOfCells {
                selectedCellIndex = oldValue
            }
        }
    }

    private var cancellableSet: Set<AnyCancellable> = []
    private var passCodeValidPublisher: AnyPublisher<Bool, Never> {
        $passCode
            .removeDuplicates()
            .map {
                $0.allSatisfy { $0.count == 1 }
            }
            .eraseToAnyPublisher()
    }
    
    /**
     - Returns: The number of cells in the pass code
     */
    var numberOfCells: Int {
        get {
            return self.passCode.count
        }
    }
    
    /**
     - Returns: A String with the current entered code
     */
    var passCodeString: String {
        get {
            return self.passCode.joined()
        }
    }
    
    /**
     - Parameters passCodeLength: Number of characters in passcode. Must be greater than 0.
     */
    init(passCodeLength: UInt) {
        self.passCode = Array()
        self.selectedCellIndex = 0
        
        for _ in 0 ..< passCodeLength {
            self.passCode.append("")
        }

        passCodeValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)

    }
}
