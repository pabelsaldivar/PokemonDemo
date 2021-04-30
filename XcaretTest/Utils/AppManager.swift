//
//  AppManager.swift
//  XcaretTest
//
//  Created by Jonathan Pabel Saldivar Mendoza on 30/04/21.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    
    var isUserLogedIn: Bool {
        set {UserDefaults.standard.set(newValue, forKey: "isUserLogedIn")}
        get {UserDefaults.standard.bool(forKey: "isUserLogedIn")}
    }
}
