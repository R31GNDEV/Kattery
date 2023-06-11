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
    Meow.x
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
@property (nonatomic,retain) CALayer * pinLayer;                                                             //@synthesize fillLayer=_fillLayer - In the implementation block
@property (assign,nonatomic) long long internalSizeCategory;                                                  //@synthesize internalSizeCategory=_internalSizeCategory - In the implementation block
@property (assign,nonatomic) BOOL showsPercentage;                                                            //@synthesize showsPercentage=_showsPercentage - In the implementation block
@property (assign,nonatomic) double bodyColorAlpha;                                                           //@synthesize bodyColorAlpha=_bodyColorAlpha - In the implementation block
@property (assign,nonatomic) double chargePercent;                                                            //@synthesize chargePercent=_chargePercent - In the implementation block
@property (assign,nonatomic) long long chargingState;                                                         //@synthesize chargingState=_chargingState - In the implementation block
@property (assign,nonatomic) BOOL saverModeActive;                                                            //@synthesize saverModeActive=_saverModeActive - In the implementation block
@property (assign,nonatomic) double lowBatteryChargePercentThreshold;                                         //@synthesize lowBatteryChargePercentThreshold=_lowBatteryChargePercentThreshold - In the implementation block
@property (getter=isLowBattery,nonatomic,readonly) BOOL lowBattery; 
@property (assign,nonatomic) BOOL showsInlineChargingIndicator;                                               //@synthesize showsInlineChargingIndicator=_showsInlineChargingIndicator - In the implementation block
@property (nonatomic,copy) UIColor * fillColor;
@property (nonatomic,copy) UIColor * bodyColor;
@property (nonatomic,copy) UIColor * shadowColor;  
@property (nonatomic,copy) UIColor * pinColor;                                                              //@synthesize bodyColor=_bodyColor - In the implementation block
@property(null_resettable, nonatomic, strong) UIColor * tintColor;
@property (readonly) unsigned long long hash;
@property CGFloat shadowRadius;
@property float shadowOpacity;
-(void)setFillColor:(UIColor *)arg1 ;
- (id)_labelTextColor;
- (id)_batteryFillColor;
@end
@class _UIStatusBarCycleAnimation;

@interface _UIStatusBarSignalView : UIView
@property (assign,nonatomic) NSInteger numberOfBars;
@property (assign,nonatomic) NSInteger numberOfActiveBars;
@property (nonatomic,copy) UIColor * bodyColor;
@property (nonatomic,copy) UIColor * shadowColor; 
@property (nonatomic,copy) UIColor * activeColor;  
@property (nonatomic,retain) UILabel * percentageLabel;
@property CGFloat chargePercent;

@end
@interface _UIStatusBarCellularSignalView : _UIStatusBarSignalView
// Sublayers are CALayers
// Set the color by modifying the sublayer's backgroundColor
@end

@interface _UIStatusBarImageView : UIView
@property (nonatomic,copy) UIColor * textColor;
@end
/*

Convert our Color HEX

*/

UIColor* fuckingHexColors(NSString* hexString) {
    if (!hexString) {
        NSLog(@"Kattery: Warning, you’re wanting to fuck some hex colors, but did not supply a NSString for this function. This is a bug. Did you add a safety check?");
	//we return white because nothing was passed in :P
	//i was actually hesistent to program this safety check in because imo
	//if we get a crash here - it should be extremely obvious whats happening.
	//which means that yes, if in a finished product, we ship it without this and forget to include a safety check
	//then the tweak will crash springboard, which arguably is worse, but then its highly obv something is wrong and what is
	//meanwhile this makes it a bit harder to figure out...
	//nonetheless, proceeding to craft this safety return white anywayz :P
	return [UIColor whiteColor];
    }
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

%hook _UIStatusBarImageView

-(id)tintColor {
	UIColor *meow;
	NSString *realImageColorString = [_preferences objectForKey:@"realImageColor"];
	if (realImageColorString) {
		meow = fuckingHexColors(realImageColorString);
	}
	return meow ? meow : [UIColor systemPinkColor];
}

-(CALayer *)layer {
  CALayer *origLayer = %orig; //our origLayer is what this method would have originally returned
  NSString *ImageColorString = [_preferences objectForKey:@"ImageShadowColor"];
  if (ImageColorString) {
  origLayer.shadowColor = fuckingHexColors(ImageColorString).CGColor; 
  }
  origLayer.shadowRadius = 6;
  origLayer.shadowOffset = CGSizeMake(0.0f,1.0f);
  origLayer.shadowOpacity = 2;
  return origLayer;
}

%end

%hook _UIBatteryView

-(void)setShowsInlineChargingIndicator:(BOOL)enabled {
    %orig(0);
}

-(void)setShowsPercentage:(bool)arg1 {
    %orig(YES);
}

-(NSArray *)subviews {
 id subviews = %orig;
 NSString *labelColor1 = [_preferences objectForKey:@"labelColor"];
 for (UILabel * origSubview in subviews) {
  if ([origSubview isMemberOfClass:[UILabel class]]) {
   //our subview is a UILabel!
   //now, safety check...
   if (labelColor1) {
    origSubview.textColor = fuckingHexColors(labelColor1);
   }
  }
 }
 return subviews;
}

-(id)fillColor {
	UIColor *outer;
	if (self.chargingState != 1) {
		NSString *fillColorChargingString1 = [_preferences objectForKey:@"inactiveColor"];
		if (fillColorChargingString1) {
			outer = fuckingHexColors(fillColorChargingString1);
		}
	} else if (self.chargingState != 0) {
		NSString *fillColorChargingString2 = [_preferences objectForKey:@"activeColor"];
		if (fillColorChargingString2) {
			outer = fuckingHexColors(fillColorChargingString2);
		}
	}
	return outer ? outer : [UIColor systemPinkColor];
}

-(id)_batteryColor {
	UIColor *sparkle;
	if (self.chargingState != 1) {
		NSString *pinColorChargingString1 = [_preferences objectForKey:@"pinColor1"];
		if (pinColorChargingString1) {
			sparkle = fuckingHexColors(pinColorChargingString1);
		}
	} else if (self.chargingState != 0) {
		NSString *pinColorChargingString2 = [_preferences objectForKey:@"pinColor2"];
		if (pinColorChargingString2) {
			sparkle = fuckingHexColors(pinColorChargingString2);
		}
	}
	return sparkle ? sparkle : [UIColor systemPinkColor];
}

-(id)_batteryFillColor {
    UIColor *boobs;
    if (self.chargingState != 1) {
            NSString *batteryFillColorString = [_preferences objectForKey:@"batteryFillColor"];
            if (batteryFillColorString) {
                boobs = fuckingHexColors(batteryFillColorString);
            }
    } else if (self.chargingState != 0) {
            NSString *lowBatteryString = [_preferences objectForKey:@"lowBattery"];
            if (lowBatteryString) {
                boobs = fuckingHexColors(lowBatteryString);
            }
    }
    return boobs ? boobs : [UIColor cyanColor];
}

-(CALayer *)layer {
  CALayer *origLayer = %orig; //our origLayer is what this method would have originally returned
  origLayer.shadowOpacity = 2;
  origLayer.shadowRadius = 6;
  origLayer.shadowOffset = CGSizeMake(0.0f,1.0f);
  NSString *shadowColorString = [_preferences objectForKey:@"shadowColor"];
  NSLog(@"[*]Kattery Glow Started: %@",shadowColorString);
  if (shadowColorString) {
   origLayer.shadowColor = fuckingHexColors(shadowColorString).CGColor; 
  }
  else {
    NSLog(@"[*]Kattery failed: %@",shadowColorString);
  }
  return origLayer;
}

%end

%hook _UIStatusBarStringView

-(UIColor*)setTextColor {
	UIColor *assAndTitties;
	NSString *fuckTextColorString = [_preferences objectForKey:@"fuckTextColor"];
	if (fuckTextColorString) {
		assAndTitties = fuckingHexColors(fuckTextColorString);
	}
	return assAndTitties ? assAndTitties : [UIColor redColor];
}


-(void)setText:(NSString *)text {
 %orig(text);
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
