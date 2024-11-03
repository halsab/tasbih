//
//  DuaModel.swift
//  DuaKit
//
//  Created by Khalil Sabirov on 03.11.2024.
//

import Foundation

struct DuaModel: Identifiable, Hashable {
    let id = UUID()
    let name: Name
    let number: Int?
    let firstSentenceNumber: Int
    let sentences: [Sentence]
    
    var sentencesRange: String {
        "\(firstSentenceNumber)-\(sentences.count + firstSentenceNumber - 1)"
    }
    
    init(
        name: Name,
        number: Int? = nil,
        firstSentenceNumber: Int = 1,
        sentences: [Sentence]
    ) {
        self.name = name
        self.number = number
        self.firstSentenceNumber = firstSentenceNumber
        self.sentences = sentences
    }
}

// MARK: - Name

extension DuaModel {
    struct Name: Hashable {
        let arabic: String
        let translation: String
        let meaning: String?
        let honor: String?
        
        init(
            arabic: String,
            translation: String,
            meaning: String? = nil,
            honor: String? = nil
        ) {
            self.arabic = arabic
            self.translation = translation
            self.meaning = meaning
            self.honor = honor
        }
    }
}

// MARK: - Sentence

extension DuaModel {
    struct Sentence: Identifiable, Hashable {
        let id = UUID()
        let arabic: String
        let translation: String
        let transcription: String
        let tafsir: [Tafsir]?
        
        init(
            arabic: String,
            translation: String,
            transcription: String,
            tafsir: [Tafsir]? = nil
        ) {
            self.arabic = arabic
            self.translation = translation
            self.transcription = transcription
            self.tafsir = tafsir
        }
    }
}

// MARK: - SentenceTafsir

extension DuaModel.Sentence {
    struct Tafsir: Identifiable, Hashable {
        let id = UUID()
        let author: String?
        let texts: [String]
        
        init(
            author: String? = nil,
            texts: [String]
        ) {
            self.author = author
            self.texts = texts
        }
    }
}