//
//  Users.swift
//  MovieRecApp
//
//  Created by csuftitan on 11/24/25.
//

import Foundation

class UserStore: ObservableObject {
    @Published var users: [String: String] = [:] // [email: password]
    
    private let fileName = "users.json"

    init() {
        loadUsers()
    }
    
    private func getFileURL() -> URL? {
        let manager = FileManager.default
        guard let documents = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documents.appendingPathComponent(fileName)
    }
    
    func loadUsers() {
        guard let fileURL = getFileURL(),
              let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([String: String].self, from: data) {
            users = decoded
        }
    }
    
    func saveUsers() {
        guard let fileURL = getFileURL() else { return }
        if let data = try? JSONEncoder().encode(users) {
            try? data.write(to: fileURL)
        }
    }
    
    func createUser(email: String, password: String) -> Bool {
        if users[email] != nil {
            return false
        }
        users[email] = password
        saveUsers()
        return true
    }
    
    func validateUser(email: String, password: String) -> Bool {
        return users[email] == password
    }
}
