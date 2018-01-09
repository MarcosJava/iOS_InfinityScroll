//
//  NSDate+Extensions.swift
//  InfinityScrollTest
//
//  Created by Marcos Felipe Souza Pinto on 09/01/2018.
//  Copyright © 2018 Marcos Felipe Souza Pinto. All rights reserved.
//
import UIKit
import Foundation

extension Date {
    func dateFromDays(_ days: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: days, to: self, options: [])!
    }
}
