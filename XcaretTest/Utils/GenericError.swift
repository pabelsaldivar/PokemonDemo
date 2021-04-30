//
//  GenericError.swift
//  XcaretTest
//
//  Created by Jonathan Pabel Saldivar Mendoza on 30/04/21.
//

import Foundation

enum GenericError: Error {
    case emptyUser
    case emptyPasword
    case wrongLogin
}

extension GenericError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyUser:
            return "Ingresa tu usuario."
        case .emptyPasword:
            return "Ingresa tu contraseña."
        case .wrongLogin:
            return "Usuario o contraseña incorrecta, intenta nuevamente."
        }
    }
}
