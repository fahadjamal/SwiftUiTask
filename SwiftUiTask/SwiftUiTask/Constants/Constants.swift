//
//  Constants.swift
//  RxSwiftTask
//

import Foundation

enum SearchError: Error {
    case underlyingError(Error)
    case notFound
    case unkowned
}

protocol APIRequest {
    var body: Data? { get }
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
}

public enum RequestType: String {
    case GET, POST, PUT, DELETE
}

struct APIConstants {
    struct URL {
        static let baseUrl = "https://gateway.marvel.com"
    }
    struct Path {
        static let characters = "/v1/public/characters"
        static let comics = "/comics"
        static let series = "/series"
        static let events = "/events"
        static let stories = "/stories"
    }
    struct ParamKeys {
        static let apikey = "apikey"
        static let hash = "hash"
        static let ts = "ts"
        static let offset = "offset"
        static let limit = "limit"
    }
    enum SearchError: Error {
        case underlyingError(Error)
        case notFound
        case unkowned
    }
    struct ParamValues {
        static let pagerDefaultValue = 20
    }
    struct Keys {
        static var filePath: String {
            guard let filePath = Bundle.main.path(forResource: "Marvel-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Marvel-Info.plist'.")
            }
            return filePath
        }
        static var publicKey: String {
            get {
                let plist = NSDictionary(contentsOfFile: filePath)
                if let value = plist?.object(forKey: "PUBLIC_KEY") as? String,
                   value.isEmpty == false {
                    return value
                }
                fatalError("Couldn't find key 'PUBLIC_KEY' in 'Marvel-Info.plist'.")
            }
        }
        static var privateKey: String {
            get {
                let plist = NSDictionary(contentsOfFile: filePath)
                if let value = plist?.object(forKey: "PRIVATE_KEY") as? String,
                   value.isEmpty == false {
                    return value
                }
                fatalError("Couldn't find key 'PRIVATE_KEY' in 'Marvel-Info.plist'.")
            }
        }
    }
}
