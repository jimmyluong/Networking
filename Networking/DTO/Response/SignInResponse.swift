

import Foundation

struct SignInResponse: Codable {
    let statusCode: Int
    let message: String?
    let data: UserDataResponse?
}

// MARK: - DataClass
struct UserDataResponse: Codable {
    let tokens: TokensResponse?
}

// MARK: - Info
struct UserInfoResponse: Codable {
    let id: Int
    let fullName, email, username: String
    let isActive: Bool
    var homisGroup: HomisGroupResponse?
    var clinic: ClinicResponse?
    let roles: [RoleResponse]?
    let permissions: [PermissionsResponse]?
}

// MARK: - Tokens
struct TokensResponse: Codable {
    let accessToken: String
}

struct RoleResponse: Codable {
    let id: Int
    let role: String
}

struct HomisGroupResponse: Codable {
    let id: Int
    let name: String
}

struct PermissionsResponse: Codable {
    let id: Int
    let permission: String
}
