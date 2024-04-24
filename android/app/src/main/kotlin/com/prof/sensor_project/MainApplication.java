package com.prof.sensor_project;

import android.app.Application;

import com.yandex.mapkit.MapKitFactory;

public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        MapKitFactory.setApiKey("6e6c8dd2-463b-4039-b391-29adac56f4c9");
        MapKitFactory.setLocale("RU_ru");
    }
}
