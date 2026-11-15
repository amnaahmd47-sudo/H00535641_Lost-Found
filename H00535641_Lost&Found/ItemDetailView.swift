//
//  ItemDetailView.swift
//  H00535641_Lost&Found
//
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    // the post that was tapped on home
    let item: Item

    // alert after marking returned
    @State private var showAlert: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // item picture
            Image(systemName: item.icon)
                .font(.system(size: 70))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(12)

            // title and lost or found label
            HStack {
                Text(item.title)
                    .font(.largeTitle)
                    .bold()

                Spacer()

                Text(item.isLost ? "LOST" : "FOUND")
                    .font(.caption)
                    .bold()
                    .foregroundColor(item.isLost ? Color.red : Color.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background((item.isLost ? Color.red : Color.green).opacity(0.15))
                    .cornerRadius(10)
            }

            // item info
            Text("Category: \(item.category)")
                .font(.subheadline)
            Text("Place: \(item.place)")
                .font(.subheadline)
            Text("Contact: \(item.phone)")
                .font(.subheadline)

            // description
            Text("Details")
                .font(.title2)
                .padding(.top)
            Text(item.details)
                .foregroundColor(.secondary)

            // returned status
            if item.isReturned {
                Text("This item was returned to its owner")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top)
            }

            Spacer()

            // mark as returned (update)
            Button(action: {
                item.isReturned = !item.isReturned
                showAlert = true
            }) {
                Text(item.isReturned ? "Mark as Not Returned" : "Mark as Returned")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(item.isReturned ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Updated"), message: Text(item.isReturned ? "Marked as returned." : "Marked as not returned."), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(item: Item(title: "Black Wallet", details: "Black leather wallet with my HCT card inside.", category: "Wallets & Bags", place: "Library B", phone: "0501234567", isLost: true, date: Date()))
    }
    .modelContainer(for: Item.self, inMemory: true)
}
