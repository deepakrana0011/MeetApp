package com.example.meetapp

import android.app.PendingIntent
import android.content.Intent
import android.nfc.NfcAdapter
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            if (intent != null && intent.dataString != null && intent.dataString!!.startsWith("http://18.130.225.164/#/meet/")) {
                val channel = MethodChannel(getBinaryMessenger(), "method_channal")
                val data = intent.data
                val url = data.toString()
                Handler(Looper.getMainLooper()).postDelayed(
                        {
                            channel.invokeMethod("onTap", url)
                        },
                        500
                )

            }
        }
        catch (e: Exception) {

        }

    }


    override fun onResume() {
        super.onResume()
        try {
            val intent = Intent(context, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
            val pendingIntent = PendingIntent.getActivity(context, 0, intent, 0)
            NfcAdapter.getDefaultAdapter(context)?.enableForegroundDispatch(this, pendingIntent, null, null)
        }
        catch (e: Exception) {

        }

    }

    override fun onPause() {
        super.onPause()
        try {
            NfcAdapter.getDefaultAdapter(context)?.disableForegroundDispatch(this)
        }
        catch (e: Exception) {

        }

    }


    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        try {
            if (NfcAdapter.ACTION_NDEF_DISCOVERED == intent.action && intent.dataString != null && intent.dataString!!.startsWith("http://18.130.225.164/#/meet/")) {
                val channel = MethodChannel(getBinaryMessenger(), "method_channal")
                val data = intent.data
                val url = data.toString()
                channel.invokeMethod("onTap", url)

            }
        }
        catch (e: Exception) {

        }

    }

    private fun getBinaryMessenger(): BinaryMessenger {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }


}
