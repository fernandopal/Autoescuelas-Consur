package es.fernandopal.autoescuela.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Locale;
import java.util.ResourceBundle;

public class Label {
    public String get(String label, Locale locale) {
        if(locale == null) {
            locale = new Locale("en", "US");

        }

        if(label == null) {
            label = "EMPTY_LABEL";
        }

//        final ResourceBundle messages = ResourceBundle.getBundle("Labels", locale);
        final ResourceBundle messages = new Utf8Utils(locale).getBundle("Labels");
        return messages.getString(label);

    }

    public String get(String label, HttpSession session) {
        final Locale locale = (Locale) session.getAttribute("locale");
        return get(label, locale);

    }

    public String get(String label, HttpServletRequest request) {
        final Locale locale = (Locale) request.getSession().getAttribute("locale");
        return get(label, locale);

    }

}