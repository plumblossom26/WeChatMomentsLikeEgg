#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface WCFacadeDynamicConfig : NSObject
- (BOOL)Sns_LikeEasterEggPostEnabled;
- (BOOL)Sns_LikeEasterEggBrowseEnabled;
@end

%hook WCFacadeDynamicConfig
- (BOOL)Sns_LikeEasterEggPostEnabled {
	return YES;
}

- (BOOL)Sns_LikeEasterEggBrowseEnabled {
	return YES;
}
%end
