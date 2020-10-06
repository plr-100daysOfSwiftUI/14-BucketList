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
					}
				}
			}
		} else {
			// no biometrics
		}
	}
}

struct AuthenticateView_Previews: PreviewProvider {
	static var previews: some View {
		AuthenticateView(isUnlocked: .constant(false))
	}
}
