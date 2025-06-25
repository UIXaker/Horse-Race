import Foundation

struct APIClient {
    static func send(result: RaceResult) async {
        guard let url = URL(string: "https://example.com/api/results") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(result)
            _ = try await URLSession.shared.data(for: request)
        } catch {
            print("Failed to send result: \(error)")
        }
    }
}
