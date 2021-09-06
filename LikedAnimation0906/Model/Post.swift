//
//  Post.swift
//  LikedAnimation0906
//
//  Created by 张亚飞 on 2021/9/6.
//

import SwiftUI

//Post model...
struct Post: Identifiable {
    
    var  id = UUID().uuidString
    var  imageName: String
    var  isLiked: Bool = false
}
