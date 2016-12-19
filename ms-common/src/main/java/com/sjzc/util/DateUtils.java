
package com.sjzc.util;

import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.LocalDate;
import org.joda.time.Months;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author sjzc 时间计算工具类
 */
public final class DateUtils {

    /**
     * 获取当前时间
     *
     * @return 返回java Date
     * @author sjzc
     */
    public static Date getNow() {
        return new DateTime().toDate();
    }

    /**
     * 获取当前时间
     *
     * @return 返回JODA DateTime
     * @author sjzc
     */
    public static DateTime getDateTimeNow() {
        return new DateTime();
    }

    public static DateTime dateToDateTime(Date date) {
        return new DateTime(date);
    }

    /**
     * 字符串时间 转换为时间
     *
     * @param date
     * @return
     * @author sjzc
     */
    public static Date toDate(String date, DateEnum format) {
        ServiceValidate.notNull(format);
        DateTimeFormatter fmt = DateTimeFormat.forPattern(format.getText());
        return fmt.parseDateTime(date.trim()).toDate();
    }

    /**
     * 毫秒转换为Date
     *
     * @param ms
     * @return
     * @author sjzc
     */
    public static Date msToDate(long ms) {
        ServiceValidate.notNull(ms);
        return new DateTime(ms).toDate();
    }

    /**
     * 格式化时间
     *
     * @param date     时间
     * @param template 格式
     * @return
     * @author sjzc
     */
    public static String dateToStr(Date date, DateEnum template) {
        ServiceValidate.notNull(date);
        ServiceValidate.notNull(template);
        SimpleDateFormat format = new SimpleDateFormat(template.getText());
        return format.format(date);
    }

    /**
     * 传入日期增加几天
     *
     * @param date
     * @param day
     * @return
     * @author sjzc
     */
    public static Date plusDay(Date date, int day) {
        ServiceValidate.notNull(date);
        return new DateTime(date).plusDays(day).toDate();
    }

    /**
     * 传入日期增加几个月
     *
     * @param date
     * @param day
     * @return
     * @author sjzc
     */
    public static Date plusMonth(Date date, int month) {
        ServiceValidate.notNull(month);
        return new DateTime(date).plusMonths(month).toDate();
    }

    /**
     * 传入日期减少几天
     *
     * @param date
     * @param day
     * @return
     * @author sjzc
     */
    public static Date minusDay(Date date, int day) {
        ServiceValidate.notNull(date);
        return new DateTime(date).minusDays(day).toDate();
    }

    /**
     * 传入日期减少几分钟
     *
     * @param date
     * @param day
     * @return
     */
    public static Date minusMinutes(Date date, int minutes) {
        ServiceValidate.notNull(date);
        return new DateTime(date).minusMinutes(minutes).toDate();
    }

    public static Date longToDate(long millis) {
        return new DateTime(millis).toDate();
    }

    /**
     * 返回传入两个date相差的天数
     * END 大于 start 忽略时分秒
     * 例：start = 2015-06-05 10:40:30
     * end = 2015-06-06 10:40:20
     * 返回值 1
     *
     * @param start
     * @param end
     * @return
     */
    public static int daysBetween(Date start, Date end) {
        int days = Days.daysBetween(new LocalDate(start), new LocalDate(end)).getDays();
        return days;
    }

    /**
     * 返回两个日期之间 月数
     *
     * @param start
     * @param end
     * @return
     * @author sjzc
     */
    public static int monthsBetween(Date start, Date end) {
        return monthsBetween(new DateTime(start), new DateTime(end));
    }

    /**
     * 返回两个日期之间 月数
     *
     * @param start
     * @param end
     * @return
     * @author sjzc
     */
    public static int monthsBetween(DateTime start, DateTime end) {
        int m = Months.monthsBetween(start, end).getMonths();
        return m;
    }

    /**
     * 返回当前日期距离N月之后之后的天数
     *
     * 例如：计算1月5日，距离2个月之后的3月5日 返回相差天数
     *
     * @param date
     * @param addmonths
     * @return
     */
    public static int daysAfterMonths(Date date, int addmonths) {
        DateTime dateTime = new DateTime(date);
        DateTime dateTimeAfter = dateTime.plusMonths(addmonths);
        return daysBetween(date, dateTimeAfter.toDate());
    }

    /**
     * 返回传入日期+N月之后的日期
     *
     * @param date
     * @param addmonths
     * @return
     */
    public static Date dateAfterMonths(Date date, int addmonths) {
        DateTime dateTime = new DateTime(date);
        DateTime dateTimeAfter = dateTime.plusMonths(addmonths);
        return dateTimeAfter.toDate();
    }

    public static Date handleDateMix(Date date) {
        String str = DateUtils.dateToStr(date, DateEnum.DATE_SIMPLE) + " 00:00:00";
        return DateUtils.toDate(str, DateEnum.DATE_FORMAT);
    }

    public static Date handleDateMax(Date date) {
        String str = DateUtils.dateToStr(date, DateEnum.DATE_SIMPLE) + " 23:59:59";
        return DateUtils.toDate(str, DateEnum.DATE_FORMAT);
    }

    /**
     * 传入日期和当前日期比较（参数会转换成年月日格式）
     *
     * @param dt
     * @return 小于-1，等于0，大于1
     */
    public static int compareDateToNow(DateTime dt) {
        return dt.toLocalDate().compareTo(new DateTime().toLocalDate());
    }

    /**
     * 返回当前时间格式yyyyMMdd字符串
     *
     * @return
     */
    public static String getSimpleDate() {
        return dateToStr(getNow(), DateEnum.DATE_SIMPLE_MIN);
    }

    /**
     * 返回当前时间格式HHmmss字符串
     *
     * @return
     */
    public static String getMinTime() {
        return dateToStr(getNow(), DateEnum.DATE_TIME_MIN);
    }

    /**
     * @param date
     * @return 当前月第几天
     */
    public static int getDayOfMonth(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.DAY_OF_MONTH);
    }

    public static void main(String[] args) throws ParseException {
        // System.out.println(toDate(" 2014-01-21 11:12:23 ", DateEnum.DATE_FORMAT));
        // System.out.println(dateToStr(new Date(), DateEnum.DATE_FORMAT));
        // System.out.println(msToDate(1430896991983L));
        // System.out.println(msToDate(1431141461000L));
        //
        // System.out.println();
        // SimpleDateFormat format = new SimpleDateFormat(DateEnum.DATE_FORMAT.getText());
        // System.out.println(format.format(new Date(1431141461)));
        // System.out.println(new DateTime(1431141461).toDate());
        // System.out.println(getNow());
        // System.out.println(new DateTime(toDate("2015-06-05 10:40:30", DateEnum.DATE_FORMAT)).getDayOfMonth());
        // System.out.println(new DateTime(toDate("2015-06-05 10:40:30", DateEnum.DATE_FORMAT)).getDayOfWeek());
        // System.out.println(new DateTime(toDate("2015-06-05 10:40:30", DateEnum.DATE_FORMAT)).getDayOfYear());
        // System.out.println(new LocalDate(toDate("2015-06-05 10:40:30", DateEnum.DATE_FORMAT)));

        System.out.println("====");
        System.out.println(daysBetween(toDate("2015-06-05 10:40:30", DateEnum.DATE_FORMAT),
                toDate("2015-06-06 10:40:20", DateEnum.DATE_FORMAT)));
        // System.out.println(dateAfterMonths(toDate("2015-12-30 10:40:30", DateEnum.DATE_FORMAT), 2));

        DateTime now = DateUtils.getDateTimeNow().dayOfMonth().roundFloorCopy();
        System.out.println(now);
        Date d = new Date();
        System.out.println(getDayOfMonth(d));
    }
}
