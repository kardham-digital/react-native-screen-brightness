#import "KDScreenBrightness.h"

#import <UIKit/UIKit.h>

// Sur iOS la luminosité est globale au système : on rend la valeur d'origine
// dès que l'app n'est plus au premier plan, et on remet le max au retour.
@implementation KDScreenBrightness {
  NSInteger _count;
  CGFloat _initialBrightness;
  BOOL _boosted;
}

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

- (instancetype)init
{
  if (self = [super init]) {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [center addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
  }
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)boost
{
  if (_boosted) {
    return;
  }
  _initialBrightness = UIScreen.mainScreen.brightness;
  UIScreen.mainScreen.brightness = 1.0;
  _boosted = YES;
}

- (void)restore
{
  if (!_boosted) {
    return;
  }
  UIScreen.mainScreen.brightness = _initialBrightness;
  _boosted = NO;
}

- (void)appWillResignActive
{
  [self restore];
}

- (void)appDidBecomeActive
{
  if (_count > 0) {
    [self boost];
  }
}

- (void)requestMaxBrightness
{
  _count++;
  if (_count == 1) {
    [self boost];
  }
}

- (void)releaseMaxBrightness
{
  if (_count == 0) {
    return;
  }
  _count--;
  if (_count == 0) {
    [self restore];
  }
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeKDScreenBrightnessSpecJSI>(params);
}

@end
