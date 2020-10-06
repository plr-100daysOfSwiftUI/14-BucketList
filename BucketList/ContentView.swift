//
//  ContentView.swift
//  BucketList
//
//  Created by Paul Richardson on 03.10.2020.
//

import SwiftUI

struct ContentView: View {
	
	@State private var isUnlocked = false
	
	var body: some View {
		Group {
			if isUnlocked {
				CompositeMapView()
			} else {
				AuthenticateView(isUnlocked: $isUnlocked)
			}
		}
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
