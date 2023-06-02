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
*/


@class UIColor, UILabel, _UIBatteryViewAXHUDImageCacheInfo, CALayer, CAShapeLayer, NSString, UIAccessibilityHUDItem;

@interface _UIBatteryView : UIView {

	BOOL _saverModeActive;
	BOOL _showsInlineChargingIndicator;
	BOOL _showsPercentage;
	UIColor* _fillColor;
	UIColor* _bodyColor;
	UIColor* _pinColor;
	UIColor* _boltColor;
	double _chargePercent;
	long long _chargingState;
	double _lowBatteryChargePercentThreshold;
	long long _iconSize;
	UILabel* _percentageLabel;
	_UIBatteryViewAXHUDImageCacheInfo* _accessibilityHUDImageCacheInfo;
	CALayer* _bodyLayer;
	CALayer* _pinLayer;
	CALayer* _boltMaskLayer;
	CALayer* _boltLayer;
	CALayer* _fillLayer;
	long long _internalSizeCategory;
	double _bodyColorAlpha;
	double _pinColorAlpha;
}
@property (assign,nonatomic) long long iconSize;                                                              //@synthesize iconSize=_iconSize - In the implementation block
@property (nonatomic,readonly) CAShapeLayer * bodyShapeLayer; 
@property (nonatomic,retain) UILabel * percentageLabel;                                                       //@synthesize percentageLabel=_percentageLabel - In the implementation block
@property (nonatomic,retain) _UIBatteryViewAXHUDImageCacheInfo * accessibilityHUDImageCacheInfo;              //@synthesize accessibilityHUDImageCacheInfo=_accessibilityHUDImageCacheInfo - In the implementation block
@property (nonatomic,retain) CALayer * bodyLayer;                                                             //@synthesize bodyLayer=_bodyLayer - In the implementation block
@property (nonatomic,retain) CALayer * fillLayer;                                                             //@synthesize fillLayer=_fillLayer - In the implementation block
@property (assign,nonatomic) long long internalSizeCategory;                                                  //@synthesize internalSizeCategory=_internalSizeCategory - In the implementation block
@property (assign,nonatomic) BOOL showsPercentage;                                                            //@synthesize showsPercentage=_showsPercentage - In the implementation block
@property (assign,nonatomic) double bodyColorAlpha;                                                           //@synthesize bodyColorAlpha=_bodyColorAlpha - In the implementation block
@property (assign,nonatomic) double chargePercent;                                                            //@synthesize chargePercent=_chargePercent - In the implementation block
@property (assign,nonatomic) long long chargingState;                                                         //@synthesize chargingState=_chargingState - In the implementation block
@property (assign,nonatomic) BOOL saverModeActive;                                                            //@synthesize saverModeActive=_saverModeActive - In the implementation block
@property (assign,nonatomic) double lowBatteryChargePercentThreshold;                                         //@synthesize lowBatteryChargePercentThreshold=_lowBatteryChargePercentThreshold - In the implementation block
@property (getter=isLowBattery,nonatomic,readonly) BOOL lowBattery; 
@property (assign,nonatomic) BOOL showsInlineChargingIndicator;                                               //@synthesize showsInlineChargingIndicator=_showsInlineChargingIndicator - In the implementation block
@property (nonatomic,copy) UIColor * fillColor;                                                               //@synthesize fillColor=_fillColor - In the implementation block
@property (nonatomic,copy) UIColor * bodyColor;                                                               //@synthesize bodyColor=_bodyColor - In the implementation block
@property (readonly) unsigned long long hash; 
-(void)setFillColor:(UIColor *)arg1 ;
- (id)_labelTextColor;
- (id)_batteryFillColor;
@end
/*

Convert our Color HEX

*/

UIColor* colorFromHexString(NSString* hexString) {
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


%hook _UIBatteryView
-(void)setShowsInlineChargingIndicator:(BOOL)enabled {
    %orig(0);
}
-(void)setFillColor:(bool)enabled {
	[self = [UIColor.cyanColor].CGColor];
	%orig(0);
}
-(void)setShowsPercentage:(bool)arg1 {
    %orig(YES);
}

-(CALayer *)layer {
	CALayer *origLayer = %orig;
	NSString *colorOneString = [_preferences objectForKey:@"borderColor"];
	NSLog(@"[*]Boobs are real. %@", colorOneString);
	if (colorOneString) {
		origLayer.borderColor = colorFromHexString(colorOneString);
	}
	%orig(_enabled);
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
