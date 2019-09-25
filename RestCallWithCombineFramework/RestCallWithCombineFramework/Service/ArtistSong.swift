//
//  ArtistSong.swift
//  RestCallWithCombineFramework
//
//  Created by Gagan Vishal on 2019/09/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//https://medium.com/@alfianlosari/fetching-remote-async-api-with-apple-combine-framework-f7c067c7bb3

import Foundation
import Combine

public class ArtistSong: ArtistSongService {
    public static let sharedInstance = ArtistSong()
    private let baseURL = "https://itunes.apple.com/search?term="
    let urlSession = URLSession.shared
    private var subscription = Set<AnyCancellable>()
    private let jsonDecoder :JSONDecoder = {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy  = .convertFromSnakeCase // case when user want to remove _ and replace with Capital letter. E.g view_count will convert into  viewCount in model
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-mm-dd"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func fetchArtistSongList(from endPoint: EndPoint) -> Future<[SubModel], StoreAPIError>  {
        return Future<[SubModel], StoreAPIError> { [unowned self] promise in
            guard let url = self.createURL(with: endPoint) else {
                return promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
            //1.
            self.urlSession.dataTaskPublisher(for: url)
                //.2
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw StoreAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                    }
                    return data
            }
                //3.
                .decode(type: Model.self, decoder: self.jsonDecoder)
                //4.
                .receive(on: RunLoop.main)
                //5.
                .sink(receiveCompletion: { (completion) in
                    if case  let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodeError as DecodingError:
                            promise(.failure(.decodeError(decodeError)))
                        case let apiError as StoreAPIError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(.genericError))
                        }
                    }
                    
                }, receiveValue: {promise(.success($0.results))})
                //6.
                .store(in: &self.subscription)
        
        }
    }
    
    private func createURL(with endPoint: EndPoint) -> URL?{
        let urlString = baseURL + "\(endPoint.rawValue)"
        guard let url = URL(string: urlString) else  {
            return nil
        }
        return url
    }
}
