//
//  DraftBillRequest.swift

import Foundation

final class ComicRequest: APIRequest {
    var body: Data?
    var method: RequestType
    var path: String
    var parameters: [String: String]
    init(characterId: Int) {
        self.method = .GET
        self.path = "\(APIConstants.Path.characters)" +
            "/\(characterId)" +
            "\(APIConstants.Path.comics)"
        self.parameters = [:]
    }
}
