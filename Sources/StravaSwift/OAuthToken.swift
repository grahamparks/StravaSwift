//
//  OAuthToken.swift
//  StravaSwift
//
//  Created by Matthew on 11/11/2015.
//  Copyright © 2015 Matthew Clarkson. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
OAuthToken which is required for requesting Strava resources
 **/
public struct OAuthToken: Strava {


    /** The access token **/
    public let accessToken: String?

    /** The refresh token **/
    public let refreshToken: String?

    /** Expiry for the token in seconds since the epoch **/
    public let expiresAt : Int?

    /** The athlete **/
    public let athlete: Athlete?

    /**
     Initializers

     - Parameter json: A SwiftyJSON object
     **/
    public init(_ json: JSON) {
        accessToken = json["access_token"].string
        refreshToken = json["refresh_token"].string
        expiresAt = json["expires_at"].int
        athlete = Athlete(json["athlete"])
    }

    public init(access: String?, refresh: String?, expiry: Int?) {
        self.accessToken = access
        self.refreshToken = refresh
        self.expiresAt = expiry
        self.athlete = nil
    }
    
    /**
        JSON for serializing
     We don't bother adding athlete as it won't survive a token refresh anyway
     Grab and store it separately if you want it.
     */
    public func getJSON() -> JSON {
        var json = JSON()

        if (accessToken != nil) { json["access_token"].string = accessToken! }
        if (refreshToken != nil) { json["refresh_token"].string = refreshToken! }
        if (expiresAt != nil) { json["expires_at"].int = expiresAt! }
        
        return json;
    }

}
