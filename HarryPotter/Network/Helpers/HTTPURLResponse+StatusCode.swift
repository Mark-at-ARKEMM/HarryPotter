//
//  HTTPURLResponse+StatusCode.swift
//  HarryPotter
//
//  Created by Mark Brindle on 03/11/2024.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { 200 }
    
    var isOK: Bool { statusCode == HTTPURLResponse.OK_200 }
}
