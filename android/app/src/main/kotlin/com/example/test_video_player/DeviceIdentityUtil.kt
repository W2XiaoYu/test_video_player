package com.example.test_video_player

import android.content.Context
import com.github.gzuliyujiang.oaid.DeviceID
import com.github.gzuliyujiang.oaid.IGetter


class DeviceIdentityUtil(private val context: Context) {
    fun getOAID(callback: (result: String) -> Unit) {
        DeviceID.getOAID(context, object : IGetter {
            override fun onOAIDGetComplete(result: String?) {
                callback(result ?: "")
            }

            override fun onOAIDGetError(error: Exception) {
                callback("")
            }
        })
    }
}