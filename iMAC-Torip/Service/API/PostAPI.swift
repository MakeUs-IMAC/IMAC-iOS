//
//  PostAPI.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/22.
//

import Foundation
import Moya

enum PostAPI {
    case getPost(userId: Int)
    case getDetailPost(postId: Int)
    case updateStatus(postId: Int, status: String)
    case create(post: CreatePost)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jinbeom.shop")!
    }
    
    var path: String {
        switch self {
        case .create(_):
            return "/post/new"
        case .updateStatus(let postId, _):
            return "/post/\(postId)"
        case .getDetailPost(let postId):
            return "/post/\(postId)"
        case .getPost(_):
            return "/post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPost(_), .getDetailPost(_):
            return .get
        case .updateStatus(_, _):
            return .patch
        case .create(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .create(let post):
            var multipart = [MultipartFormData]()
            var fileName = "\(post.image).jpg"
            fileName = fileName.replacingOccurrences(of: " ", with: "_")
            multipart.append(MultipartFormData(provider: .data(post.image), name: "image", fileName: fileName, mimeType: "image/jpg"))
            return .uploadMultipart(multipart)
        case .getPost(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        case .getDetailPost(let postId):
            return .requestParameters(parameters: ["postId" : postId], encoding: URLEncoding.queryString)
        case .updateStatus(_, let status):
            return .requestParameters(parameters: ["travelStatus" : status], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        guard let jwtToken = UserDefaults.standard.string(forKey: "token") else { return nil }
        switch self {
        case .create(_):
            return ["Content-Type": "multipart/form-data", "x-access-token" : jwtToken]
        case .updateStatus(_, _), .getPost(_), .getDetailPost(_):
            return ["x-access-token" : jwtToken]
        }
    }
    
    
}
