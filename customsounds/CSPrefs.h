#import <CSPreferences/libCSPreferences.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>

@interface CSPrefs : CSPListController { SystemSoundID selectedCharge; SystemSoundID selectedKeyboard; SystemSoundID selectedLock; SystemSoundID selectedPasscode; SystemSoundID selectedUnlock; }
	- (void)apply:(id)sender;
	- (NSArray *)getChargeSounds:(id)target;
	- (void)previewCharge:(id)value forSpecifier:(id)specifier;
	- (NSArray *)getKeyboardSounds:(id)target;
	- (void)previewKeyboard:(id)value forSpecifier:(id)specifier;
	- (NSArray *)getLockSounds:(id)target;
	- (void)previewLock:(id)value forSpecifier:(id)specifier;
	- (NSArray *)getPasscodeSounds:(id)target;
	- (void)previewPasscode:(id)value forSpecifier:(id)specifier;
	- (NSArray *)getUnlockSounds:(id)target;
	- (void)previewUnlock:(id)value forSpecifier:(id)specifier;
@end