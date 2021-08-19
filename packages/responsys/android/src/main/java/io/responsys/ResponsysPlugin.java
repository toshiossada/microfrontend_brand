package io.responsys;

import com.google.firebase.FirebaseApp;

import android.content.Context;
import android.content.Intent;

import com.pushio.manager.BuildConfig;
import com.pushio.manager.PushIOManager;

import android.content.IntentFilter;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.MethodChannel.Result;

public class ResponsysPlugin
        implements
                ResponsysBroadcastListener,
                FlutterPlugin,
                MethodChannel.MethodCallHandler,
                EventChannel.StreamHandler,
                ActivityAware,
                PluginRegistry.NewIntentListener {

    private static final String MESSAGES_CHANNEL = "responsys/messages";
    private static final String EVENTS_CHANNEL = "responsys/events";

    private PushIOManager instance;
    private ScopedBroadcastReceiver broadcastReceiver;

    private EventChannel.EventSink eventSink;

    private Bundle extraData;
    private Context context;

    public ResponsysPlugin() {
        this.broadcastReceiver = new ScopedBroadcastReceiver();
        this.broadcastReceiver.addEventListener(this);
    }

    private void handleIntent(Context context, Intent intent) {
        String action = intent.getAction();
        Bundle extras = intent.getExtras();
        
        String desiredAction = context.getPackageName() + ".NOTIFICATIONPRESSED";
        if (desiredAction.equals(action)) {
            extraData = extras;
            Log.d("Responsys", "HandleIntent: " + new ResponsysUtils().getJson(extraData));
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        // Get context
        this.context = flutterPluginBinding.getApplicationContext();
        register(flutterPluginBinding.getBinaryMessenger(), this);
    }

    private static void register(BinaryMessenger messenger, ResponsysPlugin plugin) {
        final MethodChannel methodChannel = new MethodChannel(messenger, MESSAGES_CHANNEL);
        methodChannel.setMethodCallHandler(plugin);

        final EventChannel eventChannel = new EventChannel(messenger, EVENTS_CHANNEL);
        eventChannel.setStreamHandler(plugin);
    }

    /** Plugin registration. */
    public static void registerWith(@NonNull PluginRegistry.Registrar registrar) {
        // Detect if we've been launched in background
        if (registrar.activity() == null) {
            return;
        }

        final ResponsysPlugin instance = new ResponsysPlugin();
        instance.context = registrar.context();
        register(registrar.messenger(), instance);

        instance.handleIntent(registrar.context(), registrar.activity().getIntent());
        Log.d("Responsys", "registerWith");
        registrar.addNewIntentListener(instance);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {}

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;

         context.registerReceiver(this.broadcastReceiver,
                 new IntentFilter(context.getPackageName() + ".PUSHIOPUSH"));
    }

    @Override
    public void onCancel(Object o) {
        eventSink = null;

        context.unregisterReceiver(this.broadcastReceiver);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (instance == null) {
            instance = PushIOManager.getInstance(context);
        }

        switch (call.method) {
            case "init":
                init(result);
                break;
            case "registerUserId":
                registerUserId(call, result);
                break;
            case "loadCache":
                loadCache(result);
                break;
            case "clearCache":
                clearCache(result);
                break;
            case "unregisterUserId":
                unregisterUserId(result);
                break;
            case "getNotificationData":
                if (extraData != null) {
                    result.success(new ResponsysUtils().getJson(extraData));
                    extraData = null;
                } else {
                    result.success(null);
                }
                break;
            default:
                result.notImplemented();
        }
    }

    private void init(Result result) {
        if (BuildConfig.DEBUG) {
            PushIOManager.setLoggingEnabled(true);
            PushIOManager.setLogLevel(Log.DEBUG);
        }
        String pkgName = context.getPackageName();
        Resources res  = context.getResources();

        instance.setCrashLoggingEnabled(true);

        instance.registerApp(false);
        
        instance.setDefaultLargeIcon(res.getIdentifier("notification", "drawable", pkgName));
        instance.setDefaultSmallIcon(res.getIdentifier("notification_small_icon", "drawable", pkgName));
        result.success("Instance initialize");
    }

    private void loadCache(Result result) {
        final String json = ResponsysLocalCache.read(context);

        Log.d("Responsys", "Cache loaded successfully");

        if (json.isEmpty()) {
            result.success(null);
        } else {
            result.success(json);
        }
    }

    private void clearCache(Result result) {
        ResponsysLocalCache.clear(context);

        Log.d("Responsys", "Cache cleared successfully");

        result.success("Cache cleared");
    }

    private void registerUserId(MethodCall call, Result result) {
        final String userId = call.argument("userId");
        if (userId == null) {
            throw new RuntimeException("Your userId was not informed");
        }
        instance.registerUserId(userId);
        result.success(instance.getRegisteredUserId());
    }

    private void unregisterUserId(Result result) {
        instance.unregisterUserId();
        result.success("User id unregistered");
    }

    @Override
    public boolean onNewIntent(Intent intent) {
        Log.d("Responsys", "onNewIntent");
        this.handleIntent(context, intent);
        return false;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        activityPluginBinding.addOnNewIntentListener(this);
        Log.d("Responsys", "onAttachedToActivity");
        this.handleIntent(this.context, activityPluginBinding.getActivity().getIntent());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {}

    @Override
    public void onReattachedToActivityForConfigChanges(
            @NonNull ActivityPluginBinding activityPluginBinding) {
        activityPluginBinding.addOnNewIntentListener(this);
        Log.d("Responsys", "onReattachedToActivityForConfigChanges");
        this.handleIntent(this.context, activityPluginBinding.getActivity().getIntent());
    }

    @Override
    public void onDetachedFromActivity() {}

    @Override
    public void onEvent(String json) {
        eventSink.success(json);
    }
}
