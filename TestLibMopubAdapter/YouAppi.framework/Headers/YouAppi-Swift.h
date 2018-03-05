// Generated by Apple Swift version 4.0.3 (swiftlang-900.0.74.1 clang-900.0.39.2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_attribute(external_source_symbol)
# define SWIFT_STRINGIFY(str) #str
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name) _Pragma(SWIFT_STRINGIFY(clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in=module_name, generated_declaration))), apply_to=any(function, enum, objc_interface, objc_category, objc_protocol))))
# define SWIFT_MODULE_NAMESPACE_POP _Pragma("clang attribute pop")
#else
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name)
# define SWIFT_MODULE_NAMESPACE_POP
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import Foundation;
@import UIKit;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

SWIFT_MODULE_NAMESPACE_PUSH("YouAppi")
typedef SWIFT_ENUM(NSInteger, AdState) {
  AdStateAdStateNone = 0,
  AdStateAdStateLoadingStarted = 1,
  AdStateAdStateLoadingFinished = 2,
};

typedef SWIFT_ENUM(NSInteger, AdType) {
  AdTypeAdTypeNone = 0,
  AdTypeAdTypeCardAd = 1,
  AdTypeAdTypeRewardedVideo = 2,
  AdTypeAdTypeInterstitialVideo = 3,
};




@interface NSString (SWIFT_EXTENSION(YouAppi))
- (BOOL)isValidAsUnitID SWIFT_WARN_UNUSED_RESULT;
@end







@class NSCoder;

SWIFT_CLASS("_TtC7YouAppi4YAAd")
@interface YAAd : NSObject <NSCoding>
@property (nonatomic, weak) id _Nullable delegate;
@property (nonatomic, copy) NSString * _Null_unspecified adUnitID;
@property (nonatomic) enum AdType adType;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)encodeWithCoder:(NSCoder * _Nonnull)aCoder;
- (BOOL)isAvailable SWIFT_WARN_UNUSED_RESULT;
- (void)show;
- (BOOL)load;
- (NSString * _Nullable)getMediation SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC7YouAppi8YAAdCard")
@interface YAAdCard : YAAd
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)encodeWithCoder:(NSCoder * _Nonnull)aCoder;
@property (nonatomic, weak) id _Nullable delegate;
- (void)show;
- (BOOL)load;
@end

enum YAErrorCode : NSInteger;

SWIFT_PROTOCOL("_TtP7YouAppi12YAAdDelegate_")
@protocol YAAdDelegate
@optional
- (void)onLoadFailureWithAdUnitID:(NSString * _Nonnull)adUnitID errorCode:(enum YAErrorCode)errorCode error:(NSError * _Nullable)error;
- (void)onShowFailureWithAdUnitID:(NSString * _Nonnull)adUnitID errorCode:(enum YAErrorCode)errorCode error:(NSError * _Nullable)error;
@end


SWIFT_PROTOCOL("_TtP7YouAppi26YAAdInterstitialAdDelegate_")
@protocol YAAdInterstitialAdDelegate <YAAdDelegate>
@optional
- (void)onAdStartedWithAdUnitID:(NSString * _Nonnull)adUnitID;
- (void)onAdEndedWithAdUnitID:(NSString * _Nonnull)adUnitID;
- (void)onLoadSuccessWithAdUnitID:(NSString * _Nonnull)adUnitID;
- (void)onCardShowWithAdUnitID:(NSString * _Nonnull)adUnitID;
- (void)onCardCloseWithAdUnitID:(NSString * _Nonnull)adUnitID;
@end


SWIFT_CLASS("_TtC7YouAppi21YAAdInterstitialVideo")
@interface YAAdInterstitialVideo : YAAd
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, weak) id _Nullable delegate;
- (void)show;
- (BOOL)load;
- (BOOL)isAvailable SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_PROTOCOL("_TtP7YouAppi17YAAdVideoDelegate_")
@protocol YAAdVideoDelegate <YAAdDelegate>
@optional
- (void)onVideoStartedWithAdUnitID:(NSString * _Nonnull)adUnitID;
- (void)onVideoEndedWithAdUnitID:(NSString * _Nonnull)adUnitID;
@end


SWIFT_PROTOCOL("_TtP7YouAppi29YAAdInterstitialVideoDelegate_")
@protocol YAAdInterstitialVideoDelegate <YAAdInterstitialAdDelegate, YAAdVideoDelegate>
@end

@protocol YALoggerDelegate;

SWIFT_CLASS("_TtC7YouAppi10YAAdLogger")
@interface YAAdLogger : NSObject
@property (nonatomic, weak) id <YALoggerDelegate> _Nullable delegate;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC7YouAppi17YAAdRewardedVideo")
@interface YAAdRewardedVideo : YAAd
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, weak) id _Nullable delegate;
- (void)show;
- (BOOL)load;
- (BOOL)isAvailable SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_PROTOCOL("_TtP7YouAppi25YAAdRewardedVideoDelegate_")
@protocol YAAdRewardedVideoDelegate <YAAdInterstitialVideoDelegate>
@optional
- (void)onRewardedWithAdUnitID:(NSString * _Nonnull)adUnitID;
@end


typedef SWIFT_ENUM(NSInteger, YADeviceOrientation) {
  YADeviceOrientationUnknown = 0,
  YADeviceOrientationPortrait = 1,
  YADeviceOrientationLandscape = 2,
};

typedef SWIFT_ENUM(NSInteger, YAErrorCode) {
  YAErrorCodeNO_LOAD = 0,
  YAErrorCodeNO_FILL = 1,
  YAErrorCodeINVALID_TOKEN = 2,
  YAErrorCodeAD_UNIT_INACTIVE = 3,
  YAErrorCodeWARMING_UP = 4,
  YAErrorCodeEXPIRED = 5,
  YAErrorCodeSERVER_ERROR = 6,
  YAErrorCodePRELOAD_ERROR = 7,
  YAErrorCodeAD_IS_ALREADY_SHOWING = 8,
  YAErrorCodePLAYBACK_ERROR = 9,
  YAErrorCodeOTHER = 10,
};

typedef SWIFT_ENUM(NSInteger, YALogLevel) {
  YALogLevelNone = 1,
  YALogLevelAll = 2,
  YALogLevelDebug = 3,
  YALogLevelInfo = 4,
  YALogLevelWarning = 5,
  YALogLevelError = 6,
  YALogLevelAssert = 7,
};

typedef SWIFT_ENUM(NSInteger, YALogTag) {
  YALogTagApi = 0,
  YALogTagCallback = 1,
  YALogTagSdk = 2,
};

@class YouAppi;

SWIFT_PROTOCOL("_TtP7YouAppi16YALoggerDelegate_")
@protocol YALoggerDelegate
@optional
- (void)logDidReceivedInformationWithYouAppi:(YouAppi * _Nonnull)youAppi tag:(enum YALogTag)tag logLevel:(enum YALogLevel)logLevel message:(NSString * _Nonnull)message error:(NSError * _Nullable)error;
@end


SWIFT_CLASS("_TtC7YouAppi7YouAppi")
@interface YouAppi : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) YouAppi * _Nonnull sharedInstance;)
+ (YouAppi * _Nonnull)sharedInstance SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, readonly, copy) NSString * _Nonnull environment;
@property (nonatomic, copy) NSString * _Null_unspecified accessToken;
+ (void)initializeWithAccessToken:(NSString * _Null_unspecified)accessToken;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@property (nonatomic) BOOL isInitialized;
- (YAAdCard * _Nullable)interstitialAd:(NSString * _Nonnull)adUnitID;
- (YAAdRewardedVideo * _Nullable)rewardedVideo:(NSString * _Nonnull)adUnitID SWIFT_WARN_UNUSED_RESULT;
- (YAAdInterstitialVideo * _Nullable)interstitialVideo:(NSString * _Nonnull)adUnitID SWIFT_WARN_UNUSED_RESULT;
- (YAAdLogger * _Nullable)log SWIFT_WARN_UNUSED_RESULT;
- (void)logLevel:(enum YALogLevel)logLevel;
- (NSString * _Null_unspecified)version SWIFT_WARN_UNUSED_RESULT SWIFT_DEPRECATED_MSG("please use YouAppi.sdkVersion() method instead");
+ (NSString * _Null_unspecified)sdkVersion SWIFT_WARN_UNUSED_RESULT;
@end

SWIFT_MODULE_NAMESPACE_POP
#pragma clang diagnostic pop
