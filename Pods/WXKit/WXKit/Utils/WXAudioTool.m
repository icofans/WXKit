//
//  WXAudioTool.m
//  Pods-WXKit_Example
//
//  Created by 王家强 on 2018/2/1.
//

#import "WXAudioTool.h"
#import <UIKit/UIKit.h>

static SystemSoundID push = 0;

@implementation WXAudioTool

/**
 *  存放所有的音频ID
 *  字典: filename作为key, soundID作为value
 */
static NSMutableDictionary *_soundIDDict;

/**
 *  存放所有的音乐播放器
 *  字典: filename作为key, audioPlayer作为value
 */
static NSMutableDictionary *_audioPlayerDict;

/**
 *  初始化
 */
+ (void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
    _audioPlayerDict = [NSMutableDictionary dictionary];
    
    // 设置音频会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    //    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}

/**
 *  播放音效
 *
 *  @param filename 音效文件名
 */
+ (void)playSound:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    if (!soundID) { // 创建
        // 加载音效文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) return;
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        // 放入字典
        _soundIDDict[filename] = @(soundID);
    }
    
    // 2.播放
    AudioServicesPlaySystemSound(soundID);
}


+ (void)playSoundAndShake:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    
    if (!soundID) { // 创建
        // 加载音效文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) return;
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        // 放入字典
        _soundIDDict[filename] = @(soundID);
    }
    
    // 2.播放
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    AudioServicesPlaySystemSound(soundID);
}

void soundCompleteCallback(SystemSoundID sound,void * clientData) {
    if (sound != kSystemSoundID_Vibrate) {
        [WXAudioTool stopShake];
    } else {
        [WXAudioTool shake];
    }
    
    
    //    AudioServicesPlaySystemSound(sound);
}

+ (void)shake
{
    [self performSelector:@selector(triggerShake) withObject:nil afterDelay:0.25];
}

+ (void)stopShake
{
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
    [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(triggerShake)  object:nil];
}

+ (void)triggerShake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
}


extern OSStatus
AudioServicesAddSystemSoundCompletion(  SystemSoundID               inSystemSoundID,
                                      CFRunLoopRef                         inRunLoop,
                                      CFStringRef                          inRunLoopMode,
                                      AudioServicesSystemSoundCompletionProc  inCompletionRoutine,
                                      void*                                inClientData)
__OSX_AVAILABLE_STARTING(__MAC_10_5,__IPHONE_2_0);


+ (void)systemShake
{
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, vibrateCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

void vibrateCompleteCallback(SystemSoundID sound,void * clientData) {
    
    if (sound == kSystemSoundID_Vibrate) {
        // 震动两次
        AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
    }
    
    
    //    AudioServicesPlaySystemSound(sound);
}

/**
 *  销毁音效
 *
 *  @param filename 音效文件名
 */
+ (void)disposeSound:(NSString *)filename
{
    if (!filename) return;
    
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    if (soundID) {
        // 销毁音效ID
        AudioServicesDisposeSystemSoundID(soundID);
        AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
        
        // 从字典中移除
        [_soundIDDict removeObjectForKey:filename];
    }
}

/**
 *  播放音乐
 *
 *  @param filename 音乐文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename
{
    if (!filename) return nil;
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if (!audioPlayer) { // 创建
        // 加载音乐文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) return nil;
        
        // 创建audioPlayer
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 缓冲
        [audioPlayer prepareToPlay];
        audioPlayer.numberOfLoops =0;
        
        //        audioPlayer.enableRate = YES;
        //        audioPlayer.rate = 10.0;
        
        // 放入字典
        _audioPlayerDict[filename] = audioPlayer;
    }
    
    // 2.播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
    }
    return audioPlayer;
}

/**
 *  暂停音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)pauseMusic:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    
    // 2.暂停
    if (audioPlayer.isPlaying) {
        [audioPlayer pause];
    }
}

/**
 *  停止音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)stopMusic:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    
    // 2.暂停
    if (audioPlayer.isPlaying) {
        [audioPlayer stop];
        
        // 直接销毁
        [_audioPlayerDict removeObjectForKey:filename];
    }
}

/**
 *  返回当前正在播放的音乐播放器
 */
+ (AVAudioPlayer *)currentPlayingAudioPlayer
{
    for (NSString *filename in _audioPlayerDict) {
        AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
        
        if (audioPlayer.isPlaying) {
            return audioPlayer;
        }
    }
    return nil;
}

+ (void)PlaySoundWithName:(NSString *)filename  Typpe:(NSString *)fileType{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:fileType];
    NSLog(@"path = %@",path);
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&push);
        AudioServicesPlaySystemSound(push);
        //        AudioServicesPlaySystemSound(push);//如果无法再下面播放，可以尝试在此播放
    }
    //AudioServicesPlaySystemSound(push);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
