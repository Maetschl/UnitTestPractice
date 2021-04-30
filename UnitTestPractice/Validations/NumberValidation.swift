//
//  NumberValidation.swift
//  UnitTestPractice
//
//  Created by Julian Arias Maetschl on 30-04-21.
//

import Foundation

class NumberValidation: Validation {
    func validate(_ password: String) -> Bool {
        for character in password {
            if character.isNumber {
                return true
            }
        }
        return false
    }
}
