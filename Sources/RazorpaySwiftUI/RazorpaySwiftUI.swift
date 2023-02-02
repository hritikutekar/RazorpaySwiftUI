//
//  RazorpaySwiftUI.swift
//  RazorpaySwiftUI
//
//  Created by Hritik Utekar on 02/02/23.
//

public class RazorpaySwiftUI {
    public static let shared = RazorpaySwiftUI()
    
    public var razorpayKey: String = ""
    public var contact: String = ""
    public var email: String = ""
    
    public init() {}
    
    public func setRazorpayKey(_ key: String) {
        self.razorpayKey = key
    }
}
