//
//  photoModel.swift
//  DonwloadDataFromWebAndPresentWithQuickLook
//
//  Created by Ivan Pryhara on 20.07.22.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
