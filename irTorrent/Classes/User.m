//
//  User.m
//  irTorrent
//
//  Created by Carlos Ricardo on 2/5/12.
//  Copyright (c) 2012 crsantos.info. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username;
@synthesize password;
@synthesize url;

static User *current = nil;

#pragma mark - Singleton User model loading and persisting

/**
    Get the shared instance and create it if necessary.
    @return the current user
 */
+ (User *)current {
    
    if (current == nil) {
        current = [[super allocWithZone:NULL] init];
    }
    return current;
}

/**
    Loads the User model stored on NSUserDefaults
    @return the user loaded from storage or nil if no user exists
 */
+ (User*) loadUser{
    
    NSData * _user = [[NSUserDefaults standardUserDefaults] objectForKey:kIRTORRENT_DEFAULT_USER];

    if (_user != nil)
    {
        current = [NSKeyedUnarchiver unarchiveObjectWithData:_user];
        return current;
    }
    return nil;
}

/**
    Stores the User model on NSUserDefaults
 */
+ (void) saveUser{
    
    [[NSUserDefaults standardUserDefaults] 
            setObject:[NSKeyedArchiver archivedDataWithRootObject:current] 
                    forKey:kIRTORRENT_DEFAULT_USER];
}

#pragma mark - Initialization of model
// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark - Overrides to avoid releasing
// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
    [super dealloc];
}

// We don't want to allocate a new instance, so return the current one.
//+ (id)allocWithZone:(NSZone*)zone {
//    return [[self sharedInstance] retain];
//}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

// This function is empty, as we don't want to let the user release this object.
- (oneway void)release {
    
}

//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}


#pragma mark - NSCoding delegate methods do allow serialization of User model

- (id)initWithCoder:(NSCoder *)coder {

    self.username = [coder decodeObjectForKey:@"username"];
    self.password = [coder decodeObjectForKey:@"password"];
    self.url =      [coder decodeObjectForKey:@"url"];
    
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:username    forKey:@"username"];
    [coder encodeObject:password    forKey:@"password"];
    [coder encodeObject:url         forKey:@"url"];
    
}

- (NSString*) description{
    
    return  [NSString stringWithFormat:@"username: %@, password: %@, URL: %@",username, password, url];
}

@end
