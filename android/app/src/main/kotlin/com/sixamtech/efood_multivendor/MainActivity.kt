package com.scan.sa.user.mobile

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Create notification channel for FCM on Android 8+
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "Friday.sa | فرايدي", // Channel ID (must match AndroidManifest.xml)
                "Friday.sa | فرايدي Notifications", // Channel Name (shown to users)
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Notifications for Friday SA users"
            }

            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }
    }
}
