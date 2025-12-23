//
//  RepositoryError.swift
//  LearnIt
//
//  Created by Egor on 15.12.25.
//

import Foundation

enum RepositoryError: Error {
    case languageNotFound(UUID)
    case topicNotFound(UUID)
    case saveFailed(Error)
    
    var localizedDescription: String {
        switch self {
        case .languageNotFound(let id):
            return "Language with id \(id) not found"
        case .topicNotFound(let id):
            return "Topic with id \(id) not found"
        case .saveFailed(let error):
            return "Save failed: \(error.localizedDescription)"
        }
    }
}

