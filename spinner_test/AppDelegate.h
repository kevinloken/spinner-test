//
//  AppDelegate.h
//  spinner_test
//
//  Created by Kevin Loken on 11-09-02.
//  Copyright Stone Sanctuary Interactive Inc. 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
