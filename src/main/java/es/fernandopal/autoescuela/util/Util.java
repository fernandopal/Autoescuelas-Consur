package es.fernandopal.autoescuela.util;

import javax.xml.bind.DatatypeConverter;
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
}
