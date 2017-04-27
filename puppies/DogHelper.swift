//
//  DogHelper.swift
//  puppies
//
//  Created by Alex Murphy on 4/23/17.
//  Copyright © 2017 Alex Murphy. All rights reserved.
//

import Foundation
import UIKit

struct Dog {
    let profile_picture_url: URL
    let name: String
    let favorite_toy: String
    let age: Int
    let color: UIColor
    let dog_description: String
}

class DogHelper {
    static func allDogs() -> [Dog] {
        let colors: [UIColor] = [.red, .blue, .green, .black, .purple]
        let dogDescriptions: [String] = [
            "Fido enjoys long runs on the beach with a majestic sunset as a backdrop.",
            "Stimpy, like most hipsters, enjoys spening his time sipping micro brew beers while wearing a bowtie. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "Corny watches over his land and chases any squirell foolish enough to touch down from one of the many trees.",
            "Chuck is a manic sniffer, and will sniff anything he can get his snout within 10 feet of. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "Spot is still a puppy, so he enjoys eating food he didn't work for and making a mess on the floor that someone else has to clean up."
        ]
        
        let dogProfileImages: [URL] = [
            URL(string: "http://r.ddmcdn.com/w_830/s_f/o_1/cx_0/cy_220/cw_1255/ch_1255/APL/uploads/2014/11/dog-breed-selector-australian-shepherd.jpg")!,
            URL(string: "http://cdn-img.health.com/sites/default/files/styles/400x400/public/styles/main/public/dogs-pembroke-welsh-corgi-400x400.jpg?itok=-_QJFWNN")!,
            URL(string: "https://d2wq73xazpk036.cloudfront.net/media/27FB7F0C-9885-42A6-9E0C19C35242B5AC/A5F4E80F-72B7-458F-A40EB676E963E9A9/thul-1e3a85be-5590-5ef4-b332-bc456353498e.jpg?response-content-disposition=inline")!,
            URL(string: "https://s-media-cache-ak0.pinimg.com/originals/b5/fa/82/b5fa82248e3fec6b798333e0043403b6.jpg")!,
            URL(string: "https://s-media-cache-ak0.pinimg.com/736x/63/0f/0e/630f0ef3f6f3126ca11f19f4a9b85243.jpg")!,
            ]
        
        let dogNames: [String] = ["Fido", "Stimpy", "Corny", "Chuck", "Spot"]
        
        let favoriteToys: [String] = ["Tennis Ball", "Stick", "Shoe", "Bone", "Squeaky"]
        
        let dogAge: [Int] = [3, 6, 4, 7, 8]
        
        var dogs = [Dog]()
        for i in 0...4 {
            let dog = Dog(profile_picture_url: dogProfileImages[i], name: dogNames[i], favorite_toy: favoriteToys[i], age: dogAge[i], color: colors[i], dog_description: dogDescriptions[i])
            dogs.append(dog)
        }
        return dogs
    }
}
