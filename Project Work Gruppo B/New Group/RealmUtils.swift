import Foundation
import RealmSwift

class RealmUtils {
    
    private static var REALM_SCHEMA_VERSION : UInt64 = 11
    
    /// Setup Realm Configuration
    static var config: Realm.Configuration {
        get {
            
            let config = Realm.Configuration(
                // Set the new schema version. This must be greater than the previously used
                // version (if you've never set a schema version before, the version is 0).
                schemaVersion: REALM_SCHEMA_VERSION,
                
                // Set the block which will be called automatically when opening a Realm with
                // a schema version lower than the one set above
                migrationBlock: { migration, oldSchemaVersion in
                    // We haven’t migrated anything yet, so oldSchemaVersion == 0
                    if (oldSchemaVersion < self.REALM_SCHEMA_VERSION) {
                        //
                    }
            }, deleteRealmIfMigrationNeeded: false)
            
            return config
            
        }
    }
    
}


extension List : Decodable where Element : Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let element = try container.decode(Element.self)
            self.append(element)
        }
    } }

extension List : Encodable where Element : Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for element in self {
            try element.encode(to: container.superEncoder())
        }
    } }
