# CIStickerFacilities

Attach an image as a sticker in a chat conversation, or as an emoji in a UITextView, as well as Messenger and Telegram usually do.

## Intro

Is not finished yet... All kinds of contributions are welcome!

This is a project that I have been working,  just for practicing. The result is a class that can help create a chat using your own images as stickers or emojis.

What I'm doing next:

- vertical alignment with text and image in the same UITextView
- font-family and size to UITextView content
- chat ballon and navigation bar in project example
- resize the cell (and balloon) depends of sticker size
- fix the tap recognizer for when sticker keyboard is tapped
- automatic scrolling for chat in project example
- resize the chat table view when the keyboard slide-in

## Usage

### Keyboard

First you need to create your own sticker keyboard. You can do that using a UIView and buttons as keys to the images that you will use as stickers/emojis.

Import `CIStickerFacilities` folder files to your project and include the `h` file in chat view controller.

```objective-c
#import "CIStickerFacilities.h"
```

So, to slide the keyboard in and out in chat view, call the `animateToShowKeyboard` method, like this:

```objective-c
[CIStickerFacilities animateToShowKeyboard:_keyboardView usingChatToolBar:_toolBar andChatView:self.view];
```

If you need only hide the keyboard, for any reason, call the `animateToHideKeyboard` method:

```objective-c
[CIStickerFacilities animateToHideKeyboard:_keyboardView usingChatToolBar:_toolBar andChatView:self.view];
```

### Sticker

So, here's the magic!

To send an image as a sticker or an emoji in chat, I used the attributedText property from a `UITextView`, creating a function that does the hard work using `NSTextAttachment` and `NSAttributedString` to result in a object that can be used in a UITextView or directly in a cell table. 

EMOJI - To use an image as an emoji, within a `UITextView`, do like this:

```objective-c
[CIStickerFacilities attachStickerFromImage:imgName inTextView:_textView];
```

In the code above, `_textView` is the object where the emoji will be attached, and `imgName` is a `NSstring` that identify the image asset.

STICKER - To show a image as a sticker, in chat conversation, use this line:

```objective-c
[CIStickerFacilities createStickerFromImage:@"MicheyMouse"]
```

This method will return a `NSAttributedString` object with the image asset, and you can use it in any `attributedText` property, for example:

```objective-c
cell.textLabel.attributedText = [CIStickerFacilities createStickerFromImage:@"MicheyMouse"]; 
```

This will make the image be attached within chat conversation, as well as Messenger and Telegram usually do.

### UITextView

To create a `UITextView`, just like a `UITextField`, follow this lines:

```objective-c
[self.textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
[self.textView.layer setBorderColor: [[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0] CGColor]];
[self.textView.layer setBorderWidth: 0.6];
[self.textView.layer setCornerRadius:6.0f];
[self.textView.layer setMasksToBounds:YES];
```

It's all!

> Written with [StackEdit](https://stackedit.io/).
