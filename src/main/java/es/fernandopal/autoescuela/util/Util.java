package es.fernandopal.autoescuela.util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Util {
    public static String getHashForPassword(String password) {
        String hash = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            hash = DatatypeConverter.printHexBinary(digest).toUpperCase();

        } catch (NoSuchAlgorithmException ignored) { }
        return hash;

    }

    public static boolean checkPassword(String password, String hash) {
        return getHashForPassword(password).equals(hash);

    }

    public static void sendMessage(String error, String url, String message, HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            request.setAttribute("message", message);
            request.setAttribute("error", error);
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ignored) { }
    }
}
