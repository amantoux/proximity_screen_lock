package org.mantoux.plato.proximity_screen_lock_android

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.PowerManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.mantoux.plato.proximity_sensor_android.ProximityScreenLock

private const val methodChannelName = "proximity_screen_lock_android";
private const val eventChannelName = "proximity_sensor_states"

/** ProximityScreenLockAndroidPlugin */
class ProximityScreenLockAndroidPlugin : FlutterPlugin, MethodCallHandler, StreamHandler, SensorEventListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var eventChannel: EventChannel

  private var eventSink: EventChannel.EventSink? = null

  private lateinit var screenLock: ProximityScreenLock
  private lateinit var sensorManager: SensorManager
  private var proximitySensor: Sensor? = null

  private lateinit var applicationContext: Context
  private var enabled: Boolean = false

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, methodChannelName)
    channel.setMethodCallHandler(this)
    val context = flutterPluginBinding.applicationContext
    val powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
    screenLock = ProximityScreenLock(powerManager)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, eventChannelName)
    eventChannel.setStreamHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "setActive") {
      val isActive = call.arguments as? Boolean ?: run {
        result.error("setActive", "Argument may only be a boolean", null)
        return
      }
      try {
        setActive(isActive)
        result.success(null)
      } catch (e: Exception) {
        result.error("setActive", e.message, null)
      }
      return
    }
    if (call.method == "isProximityLockSupported") {
      result.success(screenLock.isProximitySensorAvailable)
      return
    }
    result.notImplemented()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun setActive(value: Boolean) {
    if (enabled == value) return
    if (value) {
      sensorManager = applicationContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager
      proximitySensor =
        sensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY) ?: return //sensor is unavailable

      //sensor is available
      sensorManager.registerListener(this, proximitySensor, SensorManager.SENSOR_DELAY_NORMAL)
    } else {
      sensorManager.unregisterListener(this, proximitySensor)
    }
    enabled = value
    if (!screenLock.isProximitySensorAvailable) throw NoProximityWakeLockException()
    screenLock.isActive = value
  }

  override fun onSensorChanged(event: SensorEvent?) {
    val distance = event?.values?.get(0)?.toInt() //get distance
    if (distance != null) {
      if (distance > 0) {
        // distance > 0 , nothing is near
        eventSink?.success(false)
      } else {
        // distance == 0, something is near
        eventSink?.success(true)
      }
    }
  }

  override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
    // noops
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    sensorManager.unregisterListener(this, proximitySensor)
  }
}


class NoProximityWakeLockException : RuntimeException("No proximity wake lock available")
