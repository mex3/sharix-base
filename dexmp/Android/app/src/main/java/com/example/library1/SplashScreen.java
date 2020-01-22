package com.example.library1;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import com.example.library1.data.Consts;

public class SplashScreen extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash_screen);

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                try {
                    Log.d(Consts.TAG_LOG, "Загрузка выполнена!");
                    startActivity(new Intent(SplashScreen.this, Auth.class));
                    finish();
                } catch (Exception e){
                    Log.d(Consts.TAG_LOG, "Падение при загрузке.");
                    startActivity(new Intent(SplashScreen.this, Auth.class));
                    finish();
                }
            }
        }, Consts.SPLASH_TIMEOUT);
    }
}
