# RazorpaySwiftUI

Razorpay for SwiftUI

# Installation
### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/hritikutekar/RazorpaySwiftUI.git")
]
```

# Usage
Use the razorpayCheckoutSheet View extension
```swift
Button("Checkout") {
    showPaymentSheet.toggle()
}
.disabled(showPaymentSheet)
.razorpayCheckoutSheet(
    isPresented: $showPaymentSheet,
    amount: (Int(amount) ?? 0) * 100,
    onSuccess: { paymentId in
        description = "Payment success: \(paymentId)"
    },
    onError: { errorCode, description in
        self.description = "Payment failed(\(errorCode)): \(description)"
    }
)
```

# Example
```swift
import SwiftUI
import RazorpaySwiftUI

struct ContentView: View {
    @State private var showPaymentSheet: Bool = false
    @State private var amount: String = ""
    @State private var description: String = ""
    
    var body: some View {
        Form {
            TextField("Amount", text: $amount)
                .keyboardType(.numberPad)
            
            Button("Checkout") {
                showPaymentSheet.toggle()
            }
            .disabled(showPaymentSheet)
            .razorpayCheckoutSheet(
                isPresented: $showPaymentSheet,
                amount: (Int(amount) ?? 0) * 100,
                onSuccess: { paymentId in
                    description = "Payment success: \(paymentId)"
                },
                onError: { errorCode, description in
                    self.description = "Payment failed(\(errorCode)): \(description)"
                }
            )
            
            Text(description)
        }
    }
}
```
