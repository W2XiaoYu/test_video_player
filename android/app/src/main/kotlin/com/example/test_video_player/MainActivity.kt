package com.example.test_video_player

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
class MainActivity : FlutterActivity() {
    private val deviceIdentityUtil by lazy { DeviceIdentityUtil(this) }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "device_identity").apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "getOAID" -> {
                        deviceIdentityUtil.getOAID {
                            result.success(it)
                        }
                    }

                    "startLink" -> {
                        startLink(call.arguments.toString())
                        result.success(null)
                    }
                }
            }
        }
    }

    private fun startLink(link: String?) {
        Intent(Intent.ACTION_VIEW).apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            data = Uri.parse(link ?: "")
            startActivity(this)
        }
    }
}
