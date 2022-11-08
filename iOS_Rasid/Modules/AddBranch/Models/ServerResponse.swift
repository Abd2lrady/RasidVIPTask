//
//  ServerResponse.swift
//  iOS_VIPTask
//
//  Created by Fintech on 18/10/2022.
//

import Foundation

struct ServerResponse<ResponseType: Codable>: Codable {
    let status: Bool
    let message: String
    let data: ResponseType
    let meta: Meta?
}
