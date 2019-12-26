#include "CSPrefs.h"

@implementation CSPrefs
	- (void)viewDidLoad {
		[super viewDidLoad];
		UIBarButtonItem* applyBtn = [[UIBarButtonItem alloc]  initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
		[self.navigationItem setRightBarButtonItem:applyBtn];
	}
	- (void)previewCharge:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedCharge);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/ChargeSounds/%@",value]],&selectedCharge);
		AudioServicesPlaySystemSound(selectedCharge);
		[super setPreferenceValue:value specifier:specifier];
	}
	- (NSArray *)getChargeSounds:(id)target {
		NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURL in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Tweak Support/CustomSounds/ChargeSounds/" error:NULL] filteredArrayUsingPredicate:predicate]) {
			[listing addObject:fileURL];
		}
		return listing;
	}
	- (void)previewKeyboard:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedKeyboard);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/KeyboardSounds/%@",value]],&selectedKeyboard);
		AudioServicesPlaySystemSound(selectedKeyboard);
		[super setPreferenceValue:value specifier:specifier];
	}
	- (NSArray *)getKeyboardSounds:(id)target {
		NSMutableArray *listingA = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicateA = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURLA in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Tweak Support/CustomSounds/KeyboardSounds/" error:NULL] filteredArrayUsingPredicate:predicateA]) {
			[listingA addObject:fileURLA];
		}
		return listingA;
	}
	- (void)previewLock:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedLock);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/LockSounds/%@",value]],&selectedLock);
		AudioServicesPlaySystemSound(selectedLock);
		[super setPreferenceValue:value specifier:specifier];
	}
	- (NSArray *)getLockSounds:(id)target {
		NSMutableArray *listingB = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicateB = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURLB in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Tweak Support/CustomSounds/LockSounds/" error:NULL] filteredArrayUsingPredicate:predicateB]) {
			[listingB addObject:fileURLB];
		}
		return listingB;
	}
	- (void)previewPasscode:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedPasscode);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/PasscodeSounds/%@",value]],&selectedPasscode);
		AudioServicesPlaySystemSound(selectedPasscode);
		[super setPreferenceValue:value specifier:specifier];
	}
	- (NSArray *)getPasscodeSounds:(id)target {
		NSMutableArray *listingC = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicateC = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURLC in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Tweak Support/CustomSounds/PasscodeSounds/" error:NULL] filteredArrayUsingPredicate:predicateC]) {
			[listingC addObject:fileURLC];
		}
		return listingC;
	}
	- (void)previewUnlock:(id)value forSpecifier:(id)specifier {
		AudioServicesDisposeSystemSoundID(selectedUnlock);
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Tweak Support/CustomSounds/UnlockSounds/%@",value]],&selectedUnlock);
		AudioServicesPlaySystemSound(selectedUnlock);
		[super setPreferenceValue:value specifier:specifier];
	}
	- (NSArray *)getUnlockSounds:(id)target {
		NSMutableArray *listingD = [NSMutableArray arrayWithObjects:@"None",nil];
		NSPredicate *predicateD = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
		for (NSURL *fileURLD in [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Tweak Support/CustomSounds/UnlockSounds/" error:NULL] filteredArrayUsingPredicate:predicateD]) {
			[listingD addObject:fileURLD];
		}
		return listingD;
	}
	- (void)apply:(id)sender {
		UIAlertController *ApplyChanges = [
			UIAlertController alertControllerWithTitle:@"Apply Changes?"
			message:@"Are you sure you want to apply changes?"
			preferredStyle:UIAlertControllerStyleAlert
		];
		UIAlertAction *noApply = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
		UIAlertAction *yesApply = [
			UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				pid_t pid;
				const char* args[] = {"killall", "backboardd", NULL};
				posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			}
		];
		[ApplyChanges addAction:noApply];
		[ApplyChanges addAction:yesApply];
		[self presentViewController:ApplyChanges animated: YES completion: nil];
	}
@end