//
//  MoviesApi.swift
//  SwiftUI-Cinema
//
//  Created by Orlando Nicolas Marchioli on 06/05/2024.
//

import Foundation

protocol MoviesApiProtocol{
    func getAllNowPlayingMovies(completion: @escaping (FetchMoviesResponse?, Error?) -> Void)
    func getMovieByTitle(title: String, completion: @escaping (Movie?, Error?) -> Void)
}

class MoviesApi: MoviesApiProtocol{
    
    static private var shared: MoviesApi?
    private var movies: [MovieResult] = []
    private var moviesFetchedByTitle: [Movie] = []
    private var urlSession: URLSession
    private var baseUrl: String
    private var getBaseUrl: String
    private var apiKey: String
    private var authorization: String
    private var accept: String
    
    init(urlSession: URLSession = URLSession.shared, baseUrl: String, getBaseUrl: String, apiKey: String, authorization: String, accept: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
        self.getBaseUrl = getBaseUrl
        self.apiKey = apiKey
        self.authorization = authorization
        self.accept = accept
    }
    
    static func getInstance() -> MoviesApiProtocol{
        if let returnShared = shared{
            return shared ?? returnShared
        }else{
            // TODO: Do constructor networking outside class
            let newInstance =
                MoviesApi(baseUrl: ProcessInfo.processInfo.environment["baseUrl"] ?? "", 
                          getBaseUrl: ProcessInfo.processInfo.environment["getByBaseUrl"] ?? "",
                          apiKey: ProcessInfo.processInfo.environment["apikey"] ?? "",
                          authorization: ProcessInfo.processInfo.environment["authorization"] ?? "",
                          accept: ProcessInfo.processInfo.environment["accept"] ?? "")
            shared = newInstance
            return shared ?? newInstance
        }
    }
    
    func getAllNowPlayingMovies(completion: @escaping (FetchMoviesResponse?, Error?) -> Void) {
        guard let urlRequest = absoluteURLFactory(host: baseUrl,
                                                  path: "now_playing",
                                                  authorization: authorization,
                                                  accept: accept, apiKey: "", param: "") else{
            print("Invalid Url")
            return
        }
        
        performDataTask(urlRequest: urlRequest , completion: completion, decodingType: FetchMoviesResponse.self, extractResponse: extractMoviesFromResponse(response: ))

    }
    
    func getMovieByTitle(title: String, completion: @escaping (Movie?, Error?) -> Void) {
        guard let urlRequest = absoluteURLFactory(host: getBaseUrl,
                                                  path: "",
                                                  authorization: "",
                                                  accept: "", apiKey: apiKey, param: title) else{
            print("Invalid Url")
            return
        }
        performDataTask(urlRequest: urlRequest , completion: completion, decodingType: Movie.self, extractResponse: extractMovieFromResponse(response: ))
    }

    private func performDataTask<T: Decodable>(urlRequest: URLRequest, completion: @escaping (T?, Error?) -> Void, decodingType: T.Type, extractResponse: @escaping (T) -> Void) {
         
        urlSession.dataTask(with: urlRequest) { data, _, error in
             guard let data = data, error == nil else {
                 print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                 DispatchQueue.main.async {
                     completion(nil, error)
                 }
                 return
             }
             
             do {
                 let decoder = JSONDecoder()
                 let response = try decoder.decode(decodingType, from: data)
                 extractResponse(response)
                 DispatchQueue.main.async {
                     completion(response, nil)
                 }
             } catch {
                 print("Error decoding data: \(error.localizedDescription)")
                 DispatchQueue.main.async {
                     completion(nil, error)
                 }
             }
         }.resume()
     }
    
    private func absoluteURLFactory(host: String, path: String, authorization: String, accept: String, apiKey: String, param: String) -> URLRequest?{
      var hostUrl = URL(string: host)
      hostUrl?.append(path: path)
    hostUrl?.append(queryItems: [URLQueryItem(name: "t", value: param)])
      hostUrl?.append(queryItems: [URLQueryItem(name: "apikey", value: apiKey)])
      var urlRequest = URLRequest(url: hostUrl ?? URL(fileURLWithPath: ""))
      urlRequest.httpMethod = "GET"
      urlRequest.addValue(authorization, forHTTPHeaderField: "Authorization")
      urlRequest.addValue(accept, forHTTPHeaderField: "Accept")
      return  urlRequest
    }
    
    private func extractMoviesFromResponse(response: FetchMoviesResponse) -> Void{
        self.movies = response.results
    }
    
    private func extractMovieFromResponse(response: Movie) -> Void{
        self.moviesFetchedByTitle.append(response)
    }
    
}
