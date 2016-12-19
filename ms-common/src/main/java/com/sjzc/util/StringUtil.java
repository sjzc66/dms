package com.sjzc.util;

import com.sjzc.constants.Constants;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类
 *
 * @ClassName: StringUtil
 * @author: sjzc
 * @date: 2015年10月30日 下午3:15:11
 */
public final class StringUtil {
    public static final int DEFAULT_HASH_LENGTH = 32;

    public static final String[] PASSWD_ALPHABET = {
            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
            "0123456789",
            "`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?"
    };

    public static boolean checkPasswdStrong(String passwd, int minLength) {
        if (null == passwd || "".equals(passwd))
            return false;
        if (passwd.length() < minLength)
            return false;
        for (int i = 0; i < PASSWD_ALPHABET.length; i++) {
            String alphabet = PASSWD_ALPHABET[i];
            boolean ok = false;
            for (int j = 0; j < alphabet.length(); j++) {
                if (passwd.indexOf(alphabet.substring(j, j + 1)) >= 0) {
                    ok = true;
                    break;
                }
            }
            if (!ok)
                return false;
            alphabet = null;
        }
        return true;
    }

    public static boolean match(String regEx, String str) {
        if (null == str || "".equals(str))
            return false;
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(str);
        return matcher.matches();
    }

    public static boolean checkEmail(String email) {
        return match("[a-zA-Z0-9]+([a-zA-Z0-9-_.])*@[a-zA-Z0-9]+([a-zA-Z0-9-_.])+", email);
    }

    public static boolean checkMobile(String mobile) {
        return match("[1-9]+[0-9]{10}", mobile);
    }

    public static boolean checkHash(String hash) {
        return checkHash(hash, DEFAULT_HASH_LENGTH);
    }

    public static boolean checkHash(String hash, int length) {
        return match("[a-zA-Z0-9]{" + length + "}", hash);
    }

    public static boolean checkNumber(String str, int length) {
        return match("[0-9]{" + length + "}", str);
    }

    public static boolean checkDomain(String domain) {
        return match("[\\w-\\.]+[a-zA-Z]+", domain);
    }

    public static boolean checkNotEmpty(String str) {
        if (null == str || "".equals(str.trim()))
            return false;
        return true;
    }

    public static String stripName(String name) {
        return name.trim().replaceAll("'", "").replaceAll("\"", "");
    }

    public static boolean checkNotEmpty(String[] strs) {
        if (null == strs || strs.length == 0)
            return false;
        for (String str : strs) {
            if (!checkNotEmpty(str))
                return false;
        }
        return true;
    }

    public static byte[] encrypt(String plain) throws Exception {
        return md5(sha(plain.getBytes()));
    }

    public static String byte2hex(byte[] source) {
        return byte2hex(source, 16);
    }

    public static String byte2hex(byte[] source, int length) {
        char digits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
        char str[] = new char[length * 2];
        int k = 0;
        for (int i = 0; i < length; i++) {
            byte byte0 = source[i];
            str[k++] = digits[byte0 >>> 4 & 0xf];
            str[k++] = digits[byte0 & 0xf];
        }
        return new String(str);
    }

    public static String sha1hex(byte[] source) {
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < source.length; i++) {
            String hex = Integer.toHexString(source[i] & 0xFF);
            if (hex.length() < 2)
                buffer.append(0);
            buffer.append(hex);
            hex = null;
        }
        return buffer.toString();
    }

    public static byte[] sha(byte[] source) throws Exception {
        try {
            MessageDigest helper = MessageDigest.getInstance("SHA");
            helper.update(source);
            return helper.digest();
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(e);
        }
    }

    public static byte[] sha1(byte[] source) throws Exception {
        try {
            MessageDigest helper = MessageDigest.getInstance("SHA-1");
            helper.update(source);
            return helper.digest();
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(e);
        }
    }

    public static byte[] md5(byte[] source) throws Exception {
        try {
            MessageDigest helper = MessageDigest.getInstance("MD5");
            helper.update(source);
            return helper.digest();
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(e);
        }
    }

    private static String random(char[] charset, int length) {
        if (length < 1)
            return "";

        Random random = new Random();
        random.setSeed(System.currentTimeMillis() & new Random().nextLong());
        char[] buffer = new char[length];
        int size = charset.length;
        for (int i = 0; i < length; i++) {
            buffer[i] = charset[random.nextInt(size - 1)];
        }
        return new String(buffer);
    }

    public static String randomNumber(int length) {
        char[] charset = "0123456789".toCharArray();
        return random(charset, length);
    }

    public static String randomString(int length) {
        char[] charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
        return random(charset, length);
    }

    public static String hash() {
        return hash(null);
    }

    public static String hash(String key) {
        StringBuffer buffer = new StringBuffer();

        buffer.append(randomString(1024));
        buffer.append(System.currentTimeMillis());
        buffer.append(randomString(1024));
        if (null != key)
            buffer.append(key);

        try {
            return byte2hex(md5(buffer.toString().getBytes()));
        } catch (Exception e) {
            return key;
        }
    }

    public static boolean isIP(String ip) {
        if (null == ip)
            return false;
        ip = ip.trim();
        return match("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}", ip);
    }

    public static boolean isPort(String port) {
        if (null == port)
            return false;
        try {
            Integer.valueOf(port);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static long ipToLong(String ip) {
        String buf = ip.trim();
        int pos;
        long[] num = new long[4];

        for (int i = 0; i < 4; i++) {
            if (i == 3)
                num[i] = Long.parseLong(buf);
            else {
                pos = buf.indexOf(".");
                num[i] = Long.parseLong(buf.substring(0, pos));
                buf = buf.substring(pos + 1);
            }
        }

        return (num[0] << 24) + (num[1] << 16) + (num[2] << 8) + num[3];
    }

    public static String longToIp(long ip) {
        StringBuffer buf = new StringBuffer();

        buf.append(String.valueOf(ip >>> 24));
        buf.append(".");
        buf.append(String.valueOf((ip & 0x00FFFFFF) >>> 16));
        buf.append(".");
        buf.append(String.valueOf((ip & 0x0000FFFF) >>> 8));
        buf.append(".");
        buf.append(String.valueOf((ip & 0x000000FF)));

        return buf.toString();
    }

    public static String stripHtmlSpecialCharactors(String txt) {
        return txt.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace(" ", "&nbsp;")
                .replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
    }

    public static String txtToHtml(String txt) {
        return "<p>" + stripHtmlSpecialCharactors(txt)
                .replace("\n", "</p><p>") + "</p>";
    }

    public static String stripHtmlText(String txt) {
        return stripHtmlSpecialCharactors(txt).replace("\n", " ");
    }

    public static String htmlToTxt(String html) {
        if (null == html || "".equals(html))
            return "";
        return html.replaceAll("</?[^>]+>", "")
                .replaceAll("<a>\\s*|\t|\r|\n</a>", "")
                .replaceAll("&nbsp;", " ")
                .replaceAll("&lt;", "<")
                .replaceAll("&gt;", ">")
                .replaceAll(" ", "")
                .replaceAll("\n", "")
                .replaceAll("\t", "")
                .replaceAll("\r", "");
    }

    public static String stripTextSeparator(String txt) {
        if (null == txt || "".equals(txt))
            return "";
        return txt.replaceAll(" ", "")
                .replaceAll("\n", "")
                .replaceAll("\t", "")
                .replaceAll("\r", "");
    }

    @SuppressWarnings("rawtypes")
    public static String implode(List list, String separator) {
        if (null == list || list.size() == 0)
            return "";
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            if (i != 0)
                buffer.append(separator);
            buffer.append(list.get(i).toString());
        }
        return buffer.toString();
    }

    public static String implode(Object[] list, String separator) {
        if (null == list || list.length == 0)
            return "";
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < list.length; i++) {
            if (i != 0)
                buffer.append(separator);
            buffer.append(list[i].toString());
        }
        return buffer.toString();
    }

    @SuppressWarnings("rawtypes")
    public static long getBitLong(Enum e) {
        return getBitLong(e.ordinal());
    }

    public static long getBitLong(int index) {
        if (index < Long.SIZE)
            return 1L << index;
        return 0;
    }

    public static boolean isNumber(String str) {
        return match("[0-9]+", str);
    }

    public static String getMonth(Date date) {
        return new SimpleDateFormat("yyyy-MM").format(date);
    }

    public static String getDate(Date date) {
        return new SimpleDateFormat("yyyy-MM-dd").format(date);
    }

    public static String getTime(Date date) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    }

    public static Date getDate(String date) {
        return new SimpleDateFormat("yyyy-MM-dd").parse(date, new ParsePosition(0));
    }

    public static Date getTime(String time) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time, new ParsePosition(0));
    }

    public static boolean isDate(String date) {
        return match("[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}", date);
    }

    public static boolean isTime(String time) {
        return match("[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}", time);
    }

    public static boolean isDate(String[] date) {
        if (null == date || date.length == 0)
            return false;
        for (String d : date) {
            if (!isDate(d))
                return false;
        }
        return true;
    }

    public static boolean isTime(String[] time) {
        if (null == time || time.length == 0)
            return false;
        for (String t : time) {
            if (!isTime(t))
                return false;
        }
        return true;
    }

    public static String repeat(String str, int count) {
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < count; i++)
            buffer.append(str);
        return buffer.toString();
    }

    public static <T extends Enum<T>> List<T> getConfiguredEnumByString(Class<T> clazz, String config) {
        List<T> types = new ArrayList<T>();
        if (checkNotEmpty(config)) {
            String buf = config.trim();
            while (true) {
                int index = buf.indexOf(",");
                final String tmp;
                if (-1 == index) {
                    tmp = buf.trim();
                    buf = null;
                } else {
                    tmp = buf.substring(0, index).trim();
                    if (buf.length() > index + 1)
                        buf = buf.substring(index + 1);
                    else
                        buf = null;
                }
                if (tmp.length() > 0) {
                    try {
                        types.add(Enum.valueOf(clazz, tmp));
                    } catch (Exception e) {
                    }
                }
                if (null == buf)
                    break;
            }
        }
        return types;
    }

    public static String getPrice(long price) {
        return String.format("%.2f", ((double) price) / 100);
    }

    public static String getPrice(double price) {
        return String.format("%.2f", price / 100);
    }

    public static String getMobileMask(String mobile) {
        if (!checkMobile(mobile))
            return null;
        return mobile.substring(0, 3) + "****" + mobile.substring(7);
    }

    public static String getEmailMask(String email) {
        if (!checkEmail(email))
            return null;
        int pos = email.indexOf("@");
        String name = email.substring(0, pos);
        if (name.length() <= 2) {
            String postfix = email.substring(email.lastIndexOf("."));
            return name + "@" + repeat("*", email.length() - 3 - postfix.length()) + postfix;
        } else {
            if (name.length() == 3)
                name = name.substring(0, 1) + "*" + name.substring(2);
            else
                name = name.substring(0, 2) + repeat("*", name.length() - 3) + name.substring(name.length() - 1);
            return name + email.substring(pos);
        }
    }

    public static boolean isSameDay(Date one, Date two) {
        Calendar a = Calendar.getInstance();
        Calendar b = Calendar.getInstance();

        a.setTime(one);
        b.setTime(two);

        if (a.get(Calendar.YEAR) - b.get(Calendar.YEAR) != 0)
            return false;
        else if (a.get(Calendar.MONTH) - b.get(Calendar.MONTH) != 0)
            return false;
        else if (a.get(Calendar.DAY_OF_MONTH) - b.get(Calendar.DAY_OF_MONTH) != 0)
            return false;
        else
            return true;
    }

    public static boolean isSameMonth(Date one, Date two) {
        Calendar a = Calendar.getInstance();
        Calendar b = Calendar.getInstance();

        a.setTime(one);
        b.setTime(two);

        if (a.get(Calendar.YEAR) - b.get(Calendar.YEAR) != 0)
            return false;
        else if (a.get(Calendar.MONTH) - b.get(Calendar.MONTH) != 0)
            return false;
        else
            return true;
    }

    public static Date getTimeOfDay(Date date, int hour, int minute, int second) {
        Calendar calendar = Calendar.getInstance();
        if (null != date) {
            calendar.setTime(date);
        }
        calendar.set(Calendar.HOUR_OF_DAY, hour);
        calendar.set(Calendar.MINUTE, minute);
        calendar.set(Calendar.SECOND, second);
        calendar.set(Calendar.MILLISECOND, 0);

        return calendar.getTime();
    }

    public static Date getStartTimeOfDay(Date date) {
        return getTimeOfDay(date, 0, 0, 0);
    }

    public static Date getEndTimeOfDay(Date date) {
        return getTimeOfDay(date, 23, 59, 59);
    }

    public static int getFromWord(String sql) {
        if (!checkNotEmpty(sql)) {
            return -1;
        }

        LinkedStack<String> stack = new LinkedStack<>();
        sql = sql.toLowerCase().replaceAll("\t", " ");

        int b = 0;
        int s = 0;
        int f = 0;
        String sel = "select ";
        String frm = "from ";

        s = sql.indexOf(sel, 0);
        if (s > -1) {
            stack.push(sel);
            b = s + sel.length();
        }
        while (true) {
            s = sql.indexOf(sel, b);
            f = sql.indexOf(frm, b);

            if (s < f && s > 0) {
                stack.push(sel);
                b = s + sel.length();
            } else if (s > f && f > 0) {
                stack.pop();
                b = f + frm.length();
            } else if (s > 0 && f < 0) {
                stack.push(sel);
                b = s + sel.length();
            } else if (s < 0 && f > 0) {
                stack.pop();
                b = f + frm.length();
            } else {
                break;
            }
            if (stack.isEmpty()) {
                break;
            }
        }

        return f;
    }

    public static String replaceLastComma(String str) {
        if (!checkNotEmpty(str))
            return Constants.EMPTY_STR;
        if (str.indexOf(Constants.COMMA) == -1) {
            return str;
        }
        int index = str.lastIndexOf(Constants.COMMA);
        return new StringBuffer(str).replace(index, index + 1, Constants.EMPTY_STR).toString();
    }

}
