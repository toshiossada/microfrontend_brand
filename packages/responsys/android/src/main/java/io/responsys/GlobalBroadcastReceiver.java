package io.responsys;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.pushio.manager.PushIOManager;

public class GlobalBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || intent.getExtras() == null) {
            return;
        }

        final String json = new ResponsysUtils().getJson(intent.getExtras());

        ResponsysLocalCache.save(json, context);
    }
}
