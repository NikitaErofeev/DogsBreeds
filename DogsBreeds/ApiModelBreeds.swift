import Foundation

struct Breeds: Codable {
    let weight: Eight?
    let height: Eight?
    let id: Int?
    let name: String
    let lifeSpan: String?
    let temperament: String?
    let origin: String?
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case weight
        case height
        case id
        case name
        case lifeSpan = "life_span"
        case temperament
        case origin
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weight = try? container.decode(Eight.self, forKey: .weight)
        self.height = try? container.decode(Eight.self, forKey: .height)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.lifeSpan = try? container.decode(String.self, forKey: .lifeSpan)
        self.origin = try? container.decode(String.self, forKey: .origin)
        self.image = try? container.decode(Image.self, forKey: .image)
        self.temperament = try? container.decode(String.self, forKey: .temperament)
    }
}

// MARK: - Eight
struct Eight: Codable {
    let imperial: String
    let metric: String
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
}
