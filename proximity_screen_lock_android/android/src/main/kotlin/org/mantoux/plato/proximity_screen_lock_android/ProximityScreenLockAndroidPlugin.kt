package org.mantoux.plato.proximity_screen_lock_android

import android.content.Context
import android.os.PowerManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.mantoux.plato.proximity_sensor_android.ProximityScreenLock

private const val error = "ProximityScreenLockPlugin"

/** ProximityScreenLockAndroidPlugin */
class ProximityScreenLockAndroidPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var sensor: ProximityScreenLock

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "proximity_screen_lock_android")
    channel.setMethodCallHandler(this)
    val context = flutterPluginBinding.applicationContext
    val powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
    sensor = ProximityScreenLock(powerManager)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "setActive") {
      val isActive = call.arguments as? Boolean ?: run {
        result.error(error, "Argument may only be a boolean", null)
        return
      }
      try {
        setActive(isActive)
        result.success(null)
      } catch (e: Exception) {
        result.error(error, e.message, null)
      }
      return
    }
    if (call.method == "isProximityLockSupported") {
      result.success(sensor.isProximitySensorAvailable)
      return
    }
    result.notImplemented()
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun setActive(value: Boolean) {
    if (!sensor.isProximitySensorAvailable) throw NoProximityWakeLockException()
    sensor.isActive = value
  }
}


class NoProximityWakeLockException : RuntimeException("No proximity wake lock available")
