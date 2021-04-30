//
//  PasswordManager.swift
//  UnitTestPractice
//
//  Created by Julian Arias Maetschl on 23-04-21.
//

import Foundation

struct PasswordManager {

    var validations: [Validation]

    init(validations: [Validation]) {
        self.validations = validations
    }

    func validate(password: String) -> Bool {
        var returnValue = true
        for validation in validations {
            returnValue = returnValue && validation.validate(password)
        }
        return returnValue
//        return validations.allSatisfy({ $0.validate(password)} )
    }

    func validate(password: String, onComplete: @escaping (Bool)-> Void) {
        onComplete(true)
    }

}
