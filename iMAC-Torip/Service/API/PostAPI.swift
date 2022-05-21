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
    case patchPost(postId: Int)
    case create(
}
