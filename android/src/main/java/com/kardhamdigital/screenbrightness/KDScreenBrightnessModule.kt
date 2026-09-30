package com.kardhamdigital.screenbrightness

import android.view.WindowManager
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.UiThreadUtil
import com.facebook.react.module.annotations.ReactModule

// L'override porte sur la fenêtre de l'app uniquement : Android rend la luminosité
// système hors de l'app, rien à gérer au passage en arrière-plan.
@ReactModule(name = KDScreenBrightnessModule.NAME)
class KDScreenBrightnessModule(reactContext: ReactApplicationContext) :
  NativeKDScreenBrightnessSpec(reactContext) {

  // Lu et modifié uniquement sur le thread UI.
  private var count = 0

  override fun getName() = NAME

  override fun requestMaxBrightness() {
    UiThreadUtil.runOnUiThread {
      count++
      if (count == 1) applyBrightness(WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL)
    }
  }

  override fun releaseMaxBrightness() {
    UiThreadUtil.runOnUiThread {
      if (count == 0) return@runOnUiThread
      count--
      if (count == 0) applyBrightness(WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE)
    }
  }

  private fun applyBrightness(level: Float) {
    val window = reactApplicationContext.currentActivity?.window ?: return
    val params = window.attributes
    params.screenBrightness = level
    window.attributes = params
  }

  companion object {
    const val NAME = "KDScreenBrightness"
  }
}
