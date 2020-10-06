//
//  ContentView.swift
//  BucketList
//
//  Created by Paul Richardson on 03.10.2020.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
	
	@State private var isUnlocked = false
	
	var body: some View {
		Group {
			if isUnlocked {
				CompositeMapView()
			} else {
				Button("Unlock Places") {
					self.authenticate()
				}
				.padding()
				.background(Color.blue)
				.foregroundColor(.white)
				.clipShape(Capsule())
			}
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
						self.isUnlocked = true
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

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
