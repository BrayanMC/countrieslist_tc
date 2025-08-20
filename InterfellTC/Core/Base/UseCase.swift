//
//  UseCase.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

protocol UseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) async throws -> Output
}
