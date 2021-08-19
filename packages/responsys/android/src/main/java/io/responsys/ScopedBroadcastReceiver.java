

package io.responsys;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.pushio.manager.PushIOManager;

import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleObserver;
import androidx.lifecycle.OnLifecycleEvent;
import androidx.lifecycle.ProcessLifecycleOwner;

import java.util.ArrayList;
import java.util.List;

public class ScopedBroadcastReceiver
        extends BroadcastReceiver
        implements ResponsysBroadcastListener, LifecycleObserver {
    private final List<ResponsysBroadcastListener> listeners = new ArrayList<>();
    private boolean isBackgrounded = false;

    public ScopedBroadcastReceiver() {
        ProcessLifecycleOwner.get().getLifecycle().addObserver(this);
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
    public void onAppBackgrounded() {      
       isBackgrounded = true;
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    public void onAppForegrounded() {           
        isBackgrounded = false;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (!isBackgrounded) {
            Bundle extras = getResultExtras(true);
            extras.putInt(PushIOManager.PUSH_STATUS, PushIOManager.PUSH_HANDLED_NOTIFICATION);
            setResultExtras(extras);
        }

        // Abort so this broadcast doest go to the global one
        this.abortBroadcast();
        
        if (intent == null || intent.getExtras() == null) {
            return;
        }

        final String json = new ResponsysUtils().getJson(intent.getExtras());

        onEvent(json);
    }

    public void addEventListener(ResponsysBroadcastListener listener) {
        listeners.add(listener);
    }

    @Override
    public void onEvent(String json) {
        for (ResponsysBroadcastListener listener : listeners) {
            listener.onEvent(json);
        }
    }
}




