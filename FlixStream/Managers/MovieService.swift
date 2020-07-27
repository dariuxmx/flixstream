//
//  MovieService.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import Foundation

class MovieService {
    static let dataService = MovieService()

    // Basic API setup (Singletons)
    private let baseURL = ConfigVariables.shared.apiBaseURL
    private let apiKey: String = ConfigVariables.shared.apiKey!
    private let urlSession = URLSession.shared
    
    //Decoder
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        //Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func getMovies(from endPoint: MovieEndPoint, parameters: [String: String]? = nil, successHandler: @escaping (_ response: MovieResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        
        guard var urlItems = URLComponents(string: "\(baseURL ?? "")movie/\(endPoint.rawValue)") else {
            errorHandler(MovieErrors.invalidEndpoint)
            return
        }
        
        var queryMovies = [URLQueryItem(name: "api_key", value: apiKey)]
        if let parameters = parameters {
            queryMovies.append(contentsOf: parameters.map{ URLQueryItem(name: $0.key, value: $0.value) })
        }
        urlItems.queryItems = queryMovies
        
        guard let url = urlItems.url else {
            errorHandler(MovieErrors.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            // Handle errors
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: MovieErrors.apiError)
                return
            }
            
            guard let responseData = data else {
                self.handleError(errorHandler: errorHandler, error: MovieErrors.noData)
                return
            }
            
            // Handle statusCodes
            guard let apiResponse = response as? HTTPURLResponse, 200..<300 ~= apiResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: MovieErrors.invalidResponse)
                return
            }
            
            do {
                let movies = try self.jsonDecoder.decode(MovieResponse.self, from: responseData)
                successHandler(movies)
            } catch {
                self.handleError(errorHandler: errorHandler, error: MovieErrors.serializationError)
            }
        }.resume()
    }
    
    
    //MARK: --> Handle error
    func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        errorHandler(error)
        
    }
    
}
