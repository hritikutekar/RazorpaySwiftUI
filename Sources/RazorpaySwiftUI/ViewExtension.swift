//
//  ViewExtension.swift
//  RazorpaySwiftUI
//
//  Created by Hritik Utekar on 02/02/23.
//

import SwiftUI

public extension View {
    func razorpayCheckoutSheet(
        isPresented: Binding<Bool>,
        amount: Int,
        onSuccess: @escaping (_ paymentId: String) -> (),
        onError: @escaping (_ code: Int32, _ description: String) -> ()
    ) -> some View {
        if #available(iOS 15.0, *) {
            return overlay {
                CheckoutView(
                    isPresented: isPresented,
                    amount: amount,
                    onSuccess: onSuccess,
                    onError: onError
                )
                .allowsHitTesting(false)
            }
        } else {
            return ZStack {
                CheckoutView(
                    isPresented: isPresented,
                    amount: amount,
                    onSuccess: onSuccess,
                    onError: onError
                )
                .allowsHitTesting(false)
            }
            .opacity(0)
        }
    }
}
