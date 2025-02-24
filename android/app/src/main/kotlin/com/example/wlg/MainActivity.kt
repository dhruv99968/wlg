package com.example.wlg

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/massage"  // Channel name

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(flutterEngine!!)

        // Set up the MethodChannel to listen for method calls from Flutter
        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getMassage") {
                print("hello Android");
                // Respond with a message when the "getMassage" method is called
                result.success("Hello from Android Native!")
            } else {
                print("error");
                result.notImplemented()
            }
        }
    }
}
