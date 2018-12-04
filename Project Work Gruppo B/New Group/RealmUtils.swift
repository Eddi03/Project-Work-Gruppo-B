import Foundation
import RealmSwift

class RealmUtils {
    
    private static var REALM_SCHEMA_VERSION : UInt64 = 3
    
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
