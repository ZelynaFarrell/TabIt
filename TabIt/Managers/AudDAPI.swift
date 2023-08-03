//
//  AudDAPI.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/10/23.
//

import Foundation

enum SongError: Error {
    case noData
    case unrecognizedResponse
    case decodingFailed
}

class AudDAPI {
    private let baseURL = "https://api.audd.io/"
    private let apiKey = "YOUR_API_KEY"
    
    func recognizeSongFromFile(fileData: Data, completion: @escaping (Result<SongInfo, Error>) -> Void) {
        let url = URL(string: "\(baseURL)?api_token=\(apiKey)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createFormDataBody(with: fileData, boundary: boundary)
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                let error = SongError.noData
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let songInfo = try decoder.decode(SongInfo.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(songInfo))
                    print("successful network call")
                }
            } catch {
                let error = SongError.decodingFailed
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
                print("Failed network call! \(error)")
            }
        }
        
        task.resume()
    }
    
    private func createFormDataBody(with fileData: Data, boundary: String) -> Data {
        var body = Data()
        
        // Append the file data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"recording.wav\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Append the boundary closing
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}
