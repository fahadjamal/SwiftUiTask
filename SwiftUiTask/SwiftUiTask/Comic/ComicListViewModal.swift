//
//  ComicListViewModal.swift
//  FirstTutorial
//
//  Created by TransData on 26/09/2023.
//

import Foundation
import Combine

class ComicListViewModal: ObservableObject {
    @Published var comicsResponse: ComicListResponse?
    var cancellables = Set<AnyCancellable>()
    @Published var isLoading: Bool = false
    
    func loadMarvelList(completionHandler: @escaping (Result<ComicListResponse?,
                                                      NetworkError>) -> Void) {
        isLoading = true
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters/1017100/comics?apikey=42b357b57aa2a6077a210f9a6aff6f23&ts=1695629699.611395&hash=63544eb5078766adc0f07aa3011b2f7a") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        // Set up the URL Session
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                #if DEBUG
                print("data=", String(data: data, encoding: .utf8) ?? "")
                print("url=",url)
                #endif
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                        print(response)
                        throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ComicListResponse.self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION \(completion)")
                switch completion{
                case .finished:
                    print("COMPLETION \(completion)")
                case .failure(let error):
                    print("COMPLETION \(error)")
                    completionHandler(.failure(NetworkError.invalidRequest))
                }
            } receiveValue: { [weak self] (returnedData) in
                self?.comicsResponse = returnedData
                self?.isLoading = false
                completionHandler(.success(returnedData))
            }
            .store(in: &cancellables)
    }
}
