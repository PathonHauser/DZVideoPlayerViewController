//
//  DZViewController.m
//  DZVideoPlayerViewController
//
//  Created by Denis Zamataev on 06/03/2015.
//  Copyright (c) 2014 Denis Zamataev. All rights reserved.
//

#import "DZViewController.h"

NSString *const kVideoFileName = @"Star Wars  Episode VII - The Force Awakens Official Teaser Trailer #1 (2015) - J.J. Abrams Movie HD";
NSString *const kVideoFileExtension = @"mp4";

@interface DZViewController () <DZVideoPlayerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewAspectRatioConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomSpaceConstraint;

@property (strong, nonatomic) IBOutlet DZVideoPlayerViewControllerContainerView *videoContainerView;
@property (strong, nonatomic) DZVideoPlayerViewController *videoPlayerViewController;

@end

@implementation DZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.videoPlayerViewController = self.videoContainerView.videoPlayerViewController;
    self.videoPlayerViewController.delegate = self;

//    UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
//    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("orientationChanged:"), name: UIDeviceOrientationDidChangeNotification, object: nil)
//    self.videoPlayerViewController.configuration.isBackgroundPlaybackEnabled = NO;
//    self.videoPlayerViewController.configuration.isShowFullscreenExpandAndShrinkButtonsEnabled = NO;
//    self.videoPlayerViewController.configuration.isHideControlsOnIdleEnabled = NO;

    
    //NSURL *fileURL = [[NSBundle mainBundle] URLForResource:kVideoFileName withExtension:kVideoFileExtension];
    NSURL *fileURL = [NSURL URLWithString:@"http://d22mrfnizp0m66.cloudfront.net/dota2/fa701a0f4bacb1f5fe20f8a2800dd09b99e1a90e6b3076fca8f4335a16438cb2/1d16b88ccac3066be25599e6de6df99e22ae4624a810102e6d710777c38528ec/v.mp4"];
    self.videoPlayerViewController.videoURL = fileURL;
    [self.videoPlayerViewController prepareAndPlayAutomatically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    
    return self.videoPlayerViewController.isFullscreen;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (size.width > size.height) {
        
        [self.videoPlayerViewController toggleFullscreen:nil];
    }
}

#pragma mark - <DZVideoPlayerViewControllerDelegate>

- (void)playerFailedToLoadAssetWithError:(NSError *)error {
    
}

- (void)playerDidPlay {
    
}

- (void)playerDidPause {
    
}

- (void)playerDidStop {
    
}

- (void)playerDidToggleFullscreen {
    
    if (self.videoPlayerViewController.isFullscreen) {
        // expand videoPlayerViewController to fullscreen
        self.contentViewAspectRatioConstraint.priority = UILayoutPriorityDefaultLow;
        self.contentViewBottomSpaceConstraint.priority = UILayoutPriorityDefaultHigh;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.contentView layoutIfNeeded];
            [self setNeedsStatusBarAppearanceUpdate];
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        // shrink videoPlayerViewController from fullscreen
        self.contentViewBottomSpaceConstraint.priority = UILayoutPriorityDefaultLow;
        self.contentViewAspectRatioConstraint.priority = UILayoutPriorityDefaultHigh;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.contentView layoutIfNeeded];
            [self setNeedsStatusBarAppearanceUpdate];
        } completion:^(BOOL finished) {
            
        }];
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)playerDidPlayToEndTime {
}

- (void)playerFailedToPlayToEndTime {
    
}

- (void)playerPlaybackStalled {
    
}

- (void)playerDoneButtonTouched {
    
}

- (void)playerSkipButtonTouched {
    
}

- (void)playerShareButtonTouched {
    
}

- (void)playerGatherNowPlayingInfo:(NSMutableDictionary *)nowPlayingInfo {
    //    [nowPlayingInfo setObject:self.video.author forKey:MPMediaItemPropertyArtist];
    [nowPlayingInfo setObject:kVideoFileName forKey:MPMediaItemPropertyTitle];
}

@end
