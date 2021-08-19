package io.responsys;

import android.content.Context;
import android.content.SharedPreferences;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class ResponsysLocalCache {
    private static final String CACHE_KEY = "push_notification_cache";
    private static final String VALUE_KEY = "push_cache";

    public static void save(String value, Context context) {
        SharedPreferences prefs = context.getSharedPreferences(CACHE_KEY, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();

        String cache = read(context);
        String updatedCache = updateCache(cache, value);

        editor.putString(VALUE_KEY, updatedCache);
        editor.apply();
    }

    public static String read(Context context) {
        SharedPreferences prefs = context.getSharedPreferences(CACHE_KEY, Context.MODE_PRIVATE);

        return prefs.getString(VALUE_KEY, "");
    }

    public static void clear(Context context) {
        SharedPreferences prefs = context.getSharedPreferences(CACHE_KEY, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();

        editor.putString(VALUE_KEY, "");
        editor.apply();
    }

    private static List<String> getCachedMessages(String cache) {
        List<String> cachedMessages = new ArrayList<>();

        if (cache.isEmpty()) {
            return cachedMessages;
        }

        try {
            JSONArray jsonArray = new JSONArray(cache);

            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);

                cachedMessages.add(jsonObject.toString());
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return cachedMessages;
    }

    private static String getCacheString(List<String> cachedMessages) {
        JSONArray jsonArray = new JSONArray();

        for (String cachedMessage : cachedMessages) {
            try {
                JSONObject jsonObject = new JSONObject(cachedMessage);

                jsonArray.put(jsonObject);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        return jsonArray.toString();
    }

    private static String updateCache(String cache, String value) {
        List<String> cachedMessages = getCachedMessages(cache);

        cachedMessages.add(value);

        return getCacheString(cachedMessages);
    }
}