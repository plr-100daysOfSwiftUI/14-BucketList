//
//  AuthenticateView.swift
//  BucketList
//
//  Created by Paul Richardson on 06.10.2020.
//

import SwiftUI
import LocalAuthentication

struct AuthenticateView: View {
	
	@Binding var isUnlocked: Bool
	@State private var showingAlert = false
	@State private var alertTitle = "Title"
	@State private var alertMessage = "Message"
	
	var body: some View {
		Button("Unlock Places") {
			self.authenticate()
		}
		.padding()
		.background(Color.blue)
		.foregroundColor(.white)
		.clipShape(Capsule())
		.alert(isPresented: $showingAlert) {
			Alert(title: Text("\(alertTitle)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("OK")))
		}
	}
	
	func authenticate() {
		let context = LAContext()
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Please authenticate yourself to unlock your places."
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				
				DispatchQueue.main.async {
					if success {
						isUnlocked = true
					} else {
						// error
						alertTitle = "Authentication Error"
						alertMessage = authenticationError?.localizedDescription ?? "Unknown error"
						showingAlert = true
					}
				}
			}
		} else {
			// no biometrics
			alertTitle = "No Biometrics"
			alertMessage = error?.localizedDescription ?? "This device does not support Touch ID or Face ID"
			showingAlert = true
		}
	}
}

struct AuthenticateView_Previews: PreviewProvider {
	static var previews: some View {
		AuthenticateView(isUnlocked: .constant(false))
	}
}
