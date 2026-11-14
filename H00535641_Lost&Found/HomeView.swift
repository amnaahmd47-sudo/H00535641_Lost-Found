//
//  HomeView.swift
//  H00535641_Lost&Found
//
//

import SwiftUI
import SwiftData

struct HomeView: View {
    // database
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    // add sample posts only one time
    @AppStorage("didAddSamples") private var didAddSamples: Bool = false

    // search and filter
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "All"
    let filters: [String] = ["All", "Lost", "Found"]

    // delete alert
    @State private var showDeleteAlert: Bool = false
    @State private var itemToDelete: Item? = nil

    // items after search and filter
    var filteredItems: [Item] {
        var result: [Item] = []
        for item in items {
            // filter by lost or found
            if selectedFilter == "Lost" && !item.isLost {
                continue
            }
            if selectedFilter == "Found" && item.isLost {
                continue
            }
            // search by title
            if !searchText.isEmpty && !item.title.lowercased().contains(searchText.lowercased()) {
                continue
            }
            result.append(item)
        }
        return result
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search items", text: $searchText)
                }
                .padding(10)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .padding(.horizontal)

                // all / lost / found
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // list of posts
                if filteredItems.isEmpty {
                    Spacer()
                    Image(systemName: "tray")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    Text("No items yet")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List {
                        ForEach(filteredItems) { item in
                            // tap to open details
                            NavigationLink(destination: ItemDetailView(item: item)) {
                                ItemRow(item: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("Lost & Found")
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete this post?"),
                    message: Text("This cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let item = itemToDelete {
                            modelContext.delete(item)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                addSampleItems()
            }
        }
    }

    // swipe to delete, ask first
    func deleteItems(offsets: IndexSet) {
        if let index = offsets.first {
            itemToDelete = filteredItems[index]
            showDeleteAlert = true
        }
    }

    // sample posts for testing
    func addSampleItems() {
        if didAddSamples {
            return
        }
        modelContext.insert(Item(title: "Black Wallet", details: "Black leather wallet with my HCT card inside.", category: "Wallets & Bags", place: "Library B", phone: "0501234567", isLost: true, date: Date()))
        modelContext.insert(Item(title: "AirPods Case", details: "White AirPods case near the cafeteria entrance.", category: "Electronics", place: "Cafeteria", phone: "0507654321", isLost: false, date: Date()))
        modelContext.insert(Item(title: "Student ID Card", details: "HCT student ID card.", category: "Cards", place: "Block C", phone: "0501112233", isLost: true, date: Date()))
        modelContext.insert(Item(title: "Blue Water Bottle", details: "Blue metal bottle with stickers.", category: "Other", place: "Gym", phone: "0504445566", isLost: false, date: Date()))
        didAddSamples = true
    }
}

// one card in the list
struct ItemRow: View {
    let item: Item

    var body: some View {
        HStack(spacing: 12) {
            // photo placeholder
            Image(systemName: "photo")
                .font(.title2)
                .foregroundColor(.secondary)
                .frame(width: 56, height: 56)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)

            // title, place and category
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text("\(item.place) · \(item.category)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // lost or found label
            Text(item.isLost ? "LOST" : "FOUND")
                .font(.caption)
                .bold()
                .foregroundColor(item.isLost ? Color.red : Color.green)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background((item.isLost ? Color.red : Color.green).opacity(0.15))
                .cornerRadius(10)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
