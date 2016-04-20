//
//  CIStickerFacilities.h
//  Example Sticker Keyboard
//
//  Created by Carlos Irano on 4/18/16.
//  Copyright © 2016 Carlos Irano. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CIStickerFacilities : NSObject

+ (void)animateToShowKeyboard:(UIView *)keyboard usingChatToolBar:(UIToolbar *)toolbar andChatView:(UIView *)chatview;
+ (void)animateToHideKeyboard:(UIView *)keyboard usingChatToolBar:(UIToolbar *)toolbar andChatView:(UIView *)chatview;
+ (NSAttributedString *)createStickerFromImage:(NSString *)sticker;
+ (void)attachStickerFromImage:(NSString *)sticker inTextView:(UITextView *)textview;

@end
