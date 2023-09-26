//
//  DraftBillResponse.swift

import Foundation

// MARK: - ComicListResponse
struct ComicListResponse: Codable {
    var code: Int?
    var data: ComicsResponse?
}

// MARK: - DataClass
struct ComicsResponse: Codable {
    var offset, limit, total, count: Int?
    var results: [Comic]?
}

// MARK: - Result
struct Comic: Codable, Hashable {
    var id: Int?
    var title, description: String?
    var thumbnail: Thumbnail?
    var resourceURI: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case thumbnail
        case resourceURI
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Hashable {
    var path: String?
    var thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    func getImageUrl() -> String? {
        (self.path ?? "") +
            "." +
            (self.thumbnailExtension ?? "")
    }
}
