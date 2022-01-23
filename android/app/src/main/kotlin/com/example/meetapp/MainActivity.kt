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


    override fun onResume() {
        super.onResume()
        val intent = Intent(context, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
        val pendingIntent = PendingIntent.getActivity(context, 0, intent, 0)
        NfcAdapter.getDefaultAdapter(context)?.enableForegroundDispatch(this, pendingIntent, null, null)
    }

    override fun onPause() {
        super.onPause()
        NfcAdapter.getDefaultAdapter(context)?.disableForegroundDispatch(this)
    }


    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (NfcAdapter.ACTION_NDEF_DISCOVERED == intent.action && intent.dataString != null && intent.dataString!!.startsWith("http://18.130.225.164/#/meet/")) {
            val channel = MethodChannel(getBinaryMessenger(), "method_channal")
            val data = intent.data
            val url = data.toString()
            channel.invokeMethod("onTap", url)

        }
    }

    private fun getBinaryMessenger(): BinaryMessenger {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }


}
