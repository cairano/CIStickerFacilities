//
//  CIStickerFacilities.m
//  Example Sticker Keyboard
//
//  Created by Carlos Irano on 4/18/16.
//  Copyright © 2016 Carlos Irano. All rights reserved.
//

#import "CIStickerFacilities.h"

@implementation CIStickerFacilities

#pragma mark Keyboard animation

+ (void)animateToShowKeyboard:(UIView *)keyboard usingChatToolBar:(UIToolbar *)toolbar andChatView:(UIView *)chatview {
    [self animateKeyboardToShowHide:NO keyboard:keyboard usingToolBar:toolbar andChatView:chatview];
}

+ (void)animateToHideKeyboard:(UIView *)keyboard usingChatToolBar:(UIToolbar *)toolbar andChatView:(UIView *)chatview {
    [self animateKeyboardToShowHide:YES keyboard:keyboard usingToolBar:toolbar andChatView:chatview];
}

+ (void)animateKeyboardToShowHide:(BOOL)option keyboard:(UIView *)keyboard usingToolBar:(UIToolbar *)toolbar andChatView:(UIView *)chatview {
    
    // keybord view position
    CGRect keyboardFrame = keyboard.frame;
    keyboardFrame.origin.y = chatview.frame.size.height - keyboard.frame.size.height;
    
    // keyboard is open
    if (keyboard.frame.origin.y != chatview.frame.size.height) {
        
        if (keyboard.frame.origin.y < (keyboard.frame.origin.y - toolbar.frame.size.height)) {
            
        }
        
        // keyboard is open and must be hidden
        else if (keyboard.frame.origin.y == (toolbar.frame.origin.y + toolbar.frame.size.height) || option) {
            
            keyboardFrame.origin.y = chatview.frame.size.height;
        }
    }
    
    // toolbar position
    CGRect toolBarFrame = toolbar.frame;
    toolBarFrame.origin.y = keyboardFrame.origin.y - toolBarFrame.size.height;
    
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         // if typing keyboard is open
                         [chatview endEditing:YES];
                         
                         toolbar.frame = toolBarFrame;
                         keyboard.frame = keyboardFrame;
                         
                         [chatview layoutIfNeeded];
                         
                     } completion:^(BOOL finished) {
                         nil;
                     }
     ];
}

#pragma mark Sticker behavior

+ (void)attachStickerFromImage:(NSString *)sticker inTextView:(UITextView *)textview {
    
    // initialize object with the content of textView
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:textview.attributedText];
    
    // initialize selected image to be used as emoji
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:sticker];
    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:25 orientation:UIImageOrientationUp];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributeString appendAttributedString:attrStringWithImage];
    
    // blank space after the image
    NSAttributedString *blank = [[NSAttributedString alloc] initWithString:@" "];
    [attributeString appendAttributedString:blank];
    
    textview.attributedText = attributeString;
}

+ (NSAttributedString *)createStickerFromImage:(NSString *)sticker {
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:sticker];
    textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:12 orientation:UIImageOrientationUp]; // --> change de scale, to change image size (or create the image in size that you want)
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    return attrStringWithImage;
}

@end
