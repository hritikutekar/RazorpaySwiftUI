//
//  Checkout.swift
//  RazorpaySwiftUI
//
//  Created by Hritik Utekar on 02/02/23.
//

import SwiftUI
import Razorpay

struct CheckoutView: UIViewControllerRepresentable {
    @Binding private var isPresented: Bool
    private let onSuccess: (_ paymentId: String) -> ()
    private let onError: (_ code: Int32, _ description: String) -> ()
    private let amount: Int
    
    init(
        isPresented: Binding<Bool>,
        amount: Int,
        onSuccess: @escaping (_ paymentId: String) -> (),
        onError: @escaping (_ code: Int32, _ description: String) -> ()
    ) {
        self._isPresented = isPresented
        self.onSuccess = onSuccess
        self.onError = onError
        self.amount = amount
    }
    
    func makeUIViewController(context: Context) -> CheckoutViewController {
        .init()
    }
    
    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) {
        if isPresented {
            context.coordinator.showPaymentSheet(amount: amount)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            self,
            onSuccess: { paymentId in
                isPresented = false
                onSuccess(paymentId)
            },
            onError: { code, description in
                isPresented = false
                onError(code, description)
            }
        )
    }
    
    class Coordinator: NSObject, RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData {
        
        private let onSuccess: (_ paymentId: String) -> ()
        private let onError: (_ code: Int32, _ description: String) -> ()
        
        func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
            onError(code, str)
        }
        
        func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
            onSuccess(payment_id)
        }
        
        let parent: CheckoutView
        
        var razorpayObj: RazorpayCheckout? = nil
        
        typealias Razorpay = RazorpayCheckout
        var razorpay: RazorpayCheckout!
        
        init(
            _ parent: CheckoutView,
            onSuccess: @escaping (_ paymentId: String) -> (),
            onError: @escaping (_ code: Int32, _ description: String) -> ()
        ) {
            self.parent = parent
            self.onSuccess = onSuccess
            self.onError = onError
        }
        
        func showPaymentSheet(amount: Int) {
            if RazorpaySwiftUI.razorpayKey.isEmpty {
                onError(-1, "Invalid Razorpay API Key")
                return
            }
            
            razorpayObj = RazorpayCheckout.initWithKey(
                RazorpaySwiftUI.razorpayKey,
                andDelegate: self
            )
            let options: [AnyHashable:Any] = [
                "prefill": [
                    "contact": RazorpaySwiftUI.contact,
                    "email": RazorpaySwiftUI.email
                ],
                "amount" : amount
            ]
            if let rzp = self.razorpayObj {
                rzp.open(options)
            } else {
                print("Unable to initialize")
            }
        }
        
        func onPaymentError(_ code: Int32, description str: String) {
            onError(code, str)
        }
        
        func onPaymentSuccess(_ payment_id: String) {
            onSuccess(payment_id)
        }
    }
}

class CheckoutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
