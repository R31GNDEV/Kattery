#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include <objc/runtime.h> 
/*
 ██╗  ██╗█████╗█████████████████████████████╗██╗   ██╗
 ██║ ██╔██╔══██╚══██╔══╚══██╔══██╔════██╔══██╚██╗ ██╔╝
 █████╔╝███████║  ██║     ██║  █████╗ ██████╔╝╚████╔╝ 
 ██╔═██╗██╔══██║  ██║     ██║  ██╔══╝ ██╔══██╗ ╚██╔╝  
 ██║  ████║  ██║  ██║     ██║  █████████║  ██║  ██║   
 ╚═╝  ╚═╚═╝  ╚═╝  ╚═╝     ╚═╝  ╚══════╚═╝  ╚═╝  ╚═╝                                                             
Created by: 
  - Kota
  - Snoolie

    Private Tweak
    Boobs.x
*/


@class UIColor, UILabel, _UIBatteryViewAXHUDImageCacheInfo, CALayer, CAShapeLayer, NSString, UIAccessibilityHUDItem;

@interface _UIStatusBarSignalView : UIView
@property (assign,nonatomic) NSInteger numberOfBars;
@property (assign,nonatomic) NSInteger numberOfActiveBars;
@property (nonatomic,copy) UIColor * bodyColor;
@property (nonatomic,copy) UIColor * shadowColor; 
@property (nonatomic,copy) UIColor * activeColor;  
@end
@interface _UIStatusBarCellularSignalView : _UIStatusBarSignalView
// Sublayers are CALayers
// Set the color by modifying the sublayer's backgroundColor
@end

UIColor* fuckingHexColors2(NSString* hexString) {
    NSString *daString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![daString containsString:@"#"]) {
        daString = [@"#" stringByAppendingString:daString];
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:daString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

    NSRange range = [hexString rangeOfString:@":" options:NSBackwardsSearch];
    NSString* alphaString;
    if (range.location != NSNotFound) {
        alphaString = [hexString substringFromIndex:(range.location + 1)];
    } else {
        alphaString = @"1.0"; //no opacity specified - just return 1 :/
    }

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:[alphaString floatValue]];
}

NSUserDefaults *_preferences;
BOOL _enabled;

%hook _UIStatusBarWifiSignalView

-(CALayer *)layer {
  CALayer *origLayer = %orig; //our origLayer is what this method would have originally returned
  NSString *wifiShadowColorString = [_preferences objectForKey:@"wifiShadowColor"];
  if (wifiShadowColorString) {
   origLayer.shadowColor = fuckingHexColors2(wifiShadowColorString).CGColor; 
  }
  origLayer.shadowRadius = 6;
  origLayer.shadowOffset = CGSizeMake(0.0f,1.0f);
  origLayer.shadowOpacity = 2;
  return origLayer;
}

-(UIColor*)activeColor {
  UIColor *razor2;
  NSString *wifiActiveColorString = [_preferences objectForKey:@"activeColor"];
  NSLog(@"[*]Real Kattery Wifi Glow Started: %@",wifiActiveColorString);
  if (wifiActiveColorString) {
   razor2 = fuckingHexColors2(wifiActiveColorString); 
  }
  else {
    NSLog(@"[*]Kattery failed: %@",wifiActiveColorString);
  }
 return razor2 ? razor2 : [UIColor greenColor];
}

-(UIColor*)inactiveColor {
  UIColor *rawboobs;
  NSString *wifiInactiveColorString = [_preferences objectForKey:@"inactiveColor"];
  if (wifiInactiveColorString) {
    rawboobs = fuckingHexColors2(wifiInactiveColorString);
  }
 return rawboobs ? rawboobs : [UIColor redColor];
}

%end

%hook _UIStatusBarCellularSignalView

-(CALayer *)layer {
  CALayer *origLayer = %orig; //our origLayer is what this method would have originally returned
  NSString *cellShadowColorString = [_preferences objectForKey:@"cellularShadowColor"];
  if (cellShadowColorString) {
   origLayer.shadowColor = fuckingHexColors2(cellShadowColorString).CGColor; 
  }
  origLayer.shadowRadius = 6;
  origLayer.shadowOffset = CGSizeMake(0.0f,1.0f);
  origLayer.shadowOpacity = 2;
  return origLayer;
}

-(UIColor*)activeColor {
  UIColor *razor;
  NSString *cellularActiveColorString = [_preferences objectForKey:@"cellularActiveColor"];
  NSLog(@"[*]Real Kattery cellular Glow Started: %@",cellularActiveColorString);
  if (cellularActiveColorString) {
   razor = fuckingHexColors2(cellularActiveColorString); 
  }
  else {
    NSLog(@"[*]Kattery failed: %@",cellularActiveColorString);
  }
 return razor ? razor : [UIColor greenColor];
}

-(UIColor*)inactiveColor {
  UIColor *bigboobs;
  NSString *cellularInactiveColorString = [_preferences objectForKey:@"cellularInactiveColor"];
  if (cellularInactiveColorString) {
    bigboobs = fuckingHexColors2(cellularInactiveColorString);
  }
 return bigboobs ? bigboobs : [UIColor redColor];
}

%end


%ctor {
	_preferences = [[NSUserDefaults alloc] initWithSuiteName:@"online.transrights.kattery"];
	[_preferences registerDefaults:@{
		@"enabled" : @YES,

	}];
	_enabled = [_preferences boolForKey:@"enabled"];
	if(_enabled) {
		NSLog(@"[Kattery] ON");
		%init();
	} else {
		NSLog(@"[Kattery] OFF");
	}
}