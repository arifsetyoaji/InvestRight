//
//  LessonModel.swift
//  mc3-investor-app
//
//  Created by Jeffry Steward W on 14/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import Foundation

class LessonModel: Codable {
    var name = ""
    var profilePicture = ""
    var badges = 0
    var minutes = 0
    var rank = 0
    var totalPodcastListened = 0
    
    init(name: String, profilePicture: String, badges: Int, minutes: Int, totalPodcastListened: Int, rank: Int) {
        self.name = name
        self.profilePicture = profilePicture
        self.badges = badges
        self.minutes = minutes
        self.totalPodcastListened = totalPodcastListened
        self.rank = rank
    }
}
