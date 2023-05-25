//
//  User.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/05/23.
//

import Foundation
import SwiftUI

public class AppSettings: ObservableObject {
    @AppStorage("usrToken") var usrToken = ""
    @Published var user: User?
}
