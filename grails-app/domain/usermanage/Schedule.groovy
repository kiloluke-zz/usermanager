package usermanage

class Schedule {

    long beginMillis
    long endMillis
    int year
    int month
    int dayOfMonth
    int dayOfWeek
    boolean isHoliday
    static  belongsTo = [user: User]

    static constraints = {
    }
}
