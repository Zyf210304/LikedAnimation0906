//
//  Home.swift
//  LikedAnimation0906
//
//  Created by 张亚飞 on 2021/9/6.
//

import SwiftUI

struct Home: View {
    
    //Sample Posts...
    @State var posts: [Post] = [
        
        Post(imageName: "p1"),
        Post(imageName: "p2"),
        Post(imageName: "p3"),
        Post(imageName: "p4"),
        Post(imageName: "p5")
    ]
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    ForEach(posts) { post in
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            GeometryReader { proxy in
                                
                                Image(post.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(15)
                            }
                            .frame(height: 280)
                            //adding overlay...
                            .overlay (
                                
                                YFHeartLike(isTapped: $posts[getIndex(post: post)].isLiked, taps: 2)
                            )
                            .cornerRadius(15)
                            
                            Button {
                                
                                posts[getIndex(post: post)].isLiked.toggle()
                            } label: {
                                
                                Image(systemName: post.isLiked ? "suit.heart.fill" : "suit.heart")
                                    .font(.title2)
                                    .foregroundColor(post.isLiked ? .red : .gray)
                            }

                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Heart Animation")
        }
    }
    
    // getting index ....
    func getIndex(post: Post) -> Int {
        
        let index = posts.firstIndex { currentPost in
            
            return currentPost.id == post.id
        } ?? 0
        
        return index
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}


// custom shape
// for resetting from center...
struct CustomShape: Shape {
    
    //value ...
    var radius: CGFloat
    
    //animating path...
    var animatableData: CGFloat {

        get {return radius}
        set {radius = newValue}
    }
    
    //animatable path wont work on preview
    
    func path(in rect: CGRect) -> Path {
        
        return Path {path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // adding center circle...
            let  center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            path.addArc(center: center, radius: radius,  startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}
