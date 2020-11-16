//
//  Array+Only.swift
//  Memorize
//
//  Created by Pascal Hostettler on 02.11.20.
//  Copyright © 2020 Pascal Hostettler. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
