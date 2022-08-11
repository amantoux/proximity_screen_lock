package org.mantoux.plato.proximity_sensor_android

import android.annotation.SuppressLint
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.PowerManager
import android.util.Log


private const val TAG = "proximity_sensor"

// inspire by
// https://github.com/aosp-mirror/platform_packages_apps_phone/blob/gingerbread-release/src/com/android/phone/PhoneApp.java
class ProximityScreenLock(powerManager: PowerManager) {

  var isActive: Boolean
    get() = isActiveInternal
    set(value) {
      isActiveInternal = value
      updateProximitySensorMode()
    }

  private var isActiveInternal = false

  private var proximityWakeLock: PowerManager.WakeLock? = null

  val isProximitySensorAvailable: Boolean get() = proximityWakeLock != null

  init {
    // Wake lock used to control proximity sensor behavior.
    if (powerManager.isWakeLockLevelSupported(PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK)) {
      proximityWakeLock =
        powerManager.newWakeLock(PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK, "$TAG:")
    }
    Log.d(TAG, "init: proximityWakeLock: $proximityWakeLock")
    if (proximityWakeLock == null) {
      Log.w(TAG, "init: No proximity sensor available")
    }
  }

  @SuppressLint("WakelockTimeout")
  private fun updateProximitySensorMode() {
    Log.d(TAG, "updateProximitySensorMode: isActive = $isActiveInternal")

    proximityWakeLock?.let { proximityWakeLock ->
      synchronized(proximityWakeLock) {
        if (isActiveInternal) {
          if (!proximityWakeLock.isHeld) {
            Log.d(TAG, "updateProximitySensorMode: acquiring...")
            proximityWakeLock.acquire()
          } else {
            Log.d(TAG, "updateProximitySensorMode: lock already held.")
          }
        } else {
          if (proximityWakeLock.isHeld) {
            Log.d(TAG, "updateProximitySensorMode: releasing...")
            val flags = PowerManager.RELEASE_FLAG_WAIT_FOR_NO_PROXIMITY
            proximityWakeLock.release(flags)
          } else {
            Log.d(TAG, "updateProximitySensorMode: lock already released.")
          }
        }
      }

    }
  }

}