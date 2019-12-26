#import "CSProvider.h"
#import "Tweak.h"

// Charge Sound
%hook SBUIController
	- (void)playConnectedToPowerSoundIfNecessary {
		if (kEnabled) {
			if (kCustomCharge && self.isOnAC) {
				if (soundCount == 1) {
					chargeSound = 0;
					AudioServicesDisposeSystemSoundID(chargeSound);
					AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/ChargeSounds/%@",kChargeSound]],&chargeSound);
					AudioServicesPlaySystemSound(chargeSound);
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
					[NSThread sleepForTimeInterval:0.5];
					soundCount = 2;
					[self performSelector:@selector(resetCount) withObject:nil afterDelay:1.0f];
					
				}
			} else {
				%orig;
			}
		} else {
			%orig;
		}
	}
	%new
	- (void)resetCount {
		if (soundCount == 2) {
			soundCount = 1;
		}
	}
%end

// Passcode Sound
%hook SBUIPasscodeLockViewBase 
	- (void)_sendDelegateKeypadKeyDown {
		if (kEnabled) {
			if (kCustomPasscode) {
				passcodeSound = 0;
				AudioServicesDisposeSystemSoundID(passcodeSound);
				AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/PasscodeSounds/%@",kPasscodeSound]],&passcodeSound);
				AudioServicesPlaySystemSound(passcodeSound);
			} else {
				%orig;
			}
		} else {
			%orig;
		}
	}
	- (void)setPlaysKeypadSounds:(BOOL)arg1 {
		if (kEnabled) {
		} else {
			%orig;
		}
	}
%end

// Keyboard Sound
%hook UIKeyboardLayoutStar
	- (void)playKeyClickSoundOnDownForKey:(UIKBTree *)key {
		if (kEnabled) {
			if (kCustomKeyboard) {
				keyboardSound = 0;
				AudioServicesDisposeSystemSoundID(keyboardSound);
				AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/KeyboardSounds/%@",kKeyboardSound]],&keyboardSound);
				AudioServicesPlaySystemSound(keyboardSound);
			} else {
				%orig;
			}
		} else {
			%orig;
		}
	}
	- (void)setPlayKeyClickSoundOn:(int)arg1 {
		if (kEnabled && kCustomKeyboard) {
			UIKBTree *delKey = [%c(UIKBTree) key];
			NSString *myDelKeyString = [delKey name];
			if ([myDelKeyString isEqualToString:@"Delete-Key"]) {
			}
		} else {
			%orig;
		}
	}
%end

// Lock Sound
%hook SBSleepWakeHardwareButtonInteraction
	- (void)_playLockSound {
		if (kEnabled && ![[%c(SBLockScreenManager) sharedInstance] isUILocked]) {
			if (kCustomLock) {
				lockSound = 0;
				AudioServicesDisposeSystemSoundID(lockSound);
				AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/LockSounds/%@",kLockSound]],&lockSound);
				AudioServicesPlaySystemSound(lockSound);
			} else {
				%orig;
			}
		} else {
			%orig;
		}
	}
%end

// Unlock Sound
%group FixUnlock
	%hook SBCoverSheetPrimarySlidingViewController
		- (void)_handleDismissGesture:(id)arg1 {
			if (kEnabled && [[[%c(SBLockScreenManager) sharedInstance] lockScreenViewController] isAuthenticated]) {
				%orig;
				AudioServicesDisposeSystemSoundID(unlockSound);
			} else {
				%orig;
			}
		}
	%end
%end

%hook SBHomeHardwareButton
	- (void)singlePressUp:(id)arg1 {
		if (kEnabled && [[[%c(SBLockScreenManager) sharedInstance] lockScreenViewController] isAuthenticated]) {
			%orig;
			AudioServicesDisposeSystemSoundID(unlockSound);
		} else {
			%orig;
		}
	}
%end

%hook SBDashBoardViewController
	- (void)prepareForUIUnlock {
		if (kEnabled) {
			if (kCustomUnlock) {
				unlockSound = 0;
				AudioServicesDisposeSystemSoundID(unlockSound);
				AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/UnlockSounds/%@",kUnlockSound]],&unlockSound);
				AudioServicesPlaySystemSound(unlockSound);
			} else {
				%orig;
			}
		} else {
			%orig;
		}
	}
%end

%ctor {
	kEnabled = [prefs boolForKey:@"kEnabled"];
	kCustomCharge = [prefs boolForKey:@"kCustomCharge"];
	kCustomKeyboard = [prefs boolForKey:@"kCustomKeyboard"];
	kCustomLock = [prefs boolForKey:@"kCustomLock"];
	kCustomPasscode = [prefs boolForKey:@"kCustomPasscode"];
	kCustomUnlock = [prefs boolForKey:@"kCustomUnlock"];
	kChargeSound = [prefs objectForKey:@"kChargeSound"];
	kKeyboardSound = [prefs objectForKey:@"kKeyboardSound"];
	kLockSound = [prefs objectForKey:@"kLockSound"];
	kPasscodeSound = [prefs objectForKey:@"kPasscodeSound"];
	kUnlockSound = [prefs objectForKey:@"kUnlockSound"];
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
		%init(FixUnlock);
	}
	%init(_ungrouped);
}