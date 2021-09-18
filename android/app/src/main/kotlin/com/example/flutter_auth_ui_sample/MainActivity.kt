package com.example.flutter_auth_ui_sample

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.dr1009.app.flutter_auth_ui.FlutterAuthUiPlugin;

class MainActivity : FlutterActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);

        // check intent
        FlutterAuthUiPlugin.catchEmailLink(this, getIntent());
    }

    
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent);

        // check intent
        FlutterAuthUiPlugin.catchEmailLink(this, intent);
    }
}
