//
//  WXAudioTool.h
//  Pods-WXKit_Example
//
//  Created by 王家强 on 2018/2/1.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface WXAudioTool : NSObject

/**
 *  播放音效
 *
 *  @param filename 音效文件名
 */
+ (void)playSound:(NSString *)filename;

/**
 *  播放音效 和 震动
 *
 *  @param filename 音效文件名
 */
+ (void)playSoundAndShake:(NSString *)filename;

/**
 *  调用震动
 */
+ (void)systemShake;

/**
 *  销毁音效
 *
 *  @param filename 音效文件名
 */
+ (void)disposeSound:(NSString *)filename;

/**
 *  播放音乐
 *
 *  @param filename 音乐文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename;

/**
 *  暂停音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)pauseMusic:(NSString *)filename;

/**
 *  停止音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)stopMusic:(NSString *)filename;

/**
 *  返回当前正在播放的音乐播放器
 */
+ (AVAudioPlayer *)currentPlayingAudioPlayer;

/**
 *  根据文件播放声音
 */

/**
 根据文件播放声音

 @param filename 音乐文件名
 @param fileType 音乐类型
 */
+ (void)PlaySoundWithName:(NSString *)filename
                    Typpe:(NSString *)fileType;

@end
