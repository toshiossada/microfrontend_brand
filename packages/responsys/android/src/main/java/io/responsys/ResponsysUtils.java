package io.responsys;

import android.os.Bundle;

import org.json.JSONObject;
import org.json.JSONException;
import org.json.JSONArray;

import java.lang.reflect.Array;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Map;
import java.util.TimeZone;

public class ResponsysUtils {
    public String getJson(final Bundle bundle) {
        if (bundle == null) return null;
        JSONObject jsonObject = new JSONObject();

        // Add a messageId and receivedDate to the json
        try {
            String googleMessageId = (String) bundle.get("google.message_id");
            String messageId = googleMessageId + bundle.get("google.sent_time");
            String receivedDate = currentDateAsISOString();

            jsonObject.put("messageId", messageId);
            jsonObject.put("receivedDate", receivedDate);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        for (String key : bundle.keySet()) {
            Object obj = bundle.get(key);
            try {
                jsonObject.put(key, wrap(obj));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        return jsonObject.toString();
    }

    private Object wrap(Object o) {
      if (o == null) {
          return JSONObject.NULL;
      }
      if (o instanceof JSONArray || o instanceof JSONObject) {
          return o;
      }
      if (o.equals(JSONObject.NULL)) {
          return o;
      }
      try {
          if (o instanceof Collection) {
              return new JSONArray((Collection) o);
          } else if (o.getClass().isArray()) {
              return toJSONArray(o);
          }
          if (o instanceof Map) {
              return new JSONObject((Map) o);
          }
          if (o instanceof Boolean ||
                  o instanceof Byte ||
                  o instanceof Character ||
                  o instanceof Double ||
                  o instanceof Float ||
                  o instanceof Integer ||
                  o instanceof Long ||
                  o instanceof Short ||
                  o instanceof String) {
              return o;
          }
          if (o.getClass().getPackage().getName().startsWith("java.")) {
              return o.toString();
          }
      } catch (Exception ignored) {
      }
      return null;
    }

    private JSONArray toJSONArray(Object array) throws JSONException {
      JSONArray result = new JSONArray();
      if (!array.getClass().isArray()) {
          throw new JSONException("Not a primitive array: " + array.getClass());
      }
      final int length = Array.getLength(array);
      for (int i = 0; i < length; ++i) {
          result.put(wrap(Array.get(array, i)));
      }
      return result;
    }

    private String currentDateAsISOString() {
        Date currentDate = new Date();
        TimeZone tz = TimeZone.getTimeZone("UTC");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'"); // Quoted "Z" to indicate UTC, no timezone offset
        df.setTimeZone(tz);
        String nowAsISO = df.format(currentDate);

        return nowAsISO;
    }
}