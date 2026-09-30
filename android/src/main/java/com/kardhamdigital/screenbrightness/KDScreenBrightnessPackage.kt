package com.kardhamdigital.screenbrightness

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider

class KDScreenBrightnessPackage : BaseReactPackage() {

  override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? =
    if (name == KDScreenBrightnessModule.NAME) KDScreenBrightnessModule(reactContext) else null

  override fun getReactModuleInfoProvider() = ReactModuleInfoProvider {
    mapOf(
      KDScreenBrightnessModule.NAME to ReactModuleInfo(
        KDScreenBrightnessModule.NAME,
        KDScreenBrightnessModule.NAME,
        false, // canOverrideExistingModule
        false, // needsEagerInit
        false, // isCxxModule
        true, // isTurboModule
      )
    )
  }
}
