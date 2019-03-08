package usermanage

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class UserController {

    def springSecurityService
    def userService

    def index() {
        [
                user: springSecurityService.getCurrentUser()
        ]
        redirect(controller: 'user', action: 'see_colleagues')
    }

    @Secured('ROLE_ADMIN')
    create_form() {}

    def edit_form() {
        User user
        try {
            long id = userService.validateId(params.id) ? params.id as Long : springSecurityService.getCurrentUserId() as Long
            user = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN') ? userService.getUser(id) : springSecurityService.getCurrentUser()
        } catch (NullPointerException e) {
            user = springSecurityService.getCurrentUser()
        }
        println user
        [
                user: user
        ]
    }

    def edit() {

        long id = userService.validateId(params.id) ? params.id as Long : springSecurityService.getCurrentUserId() as Long
        User user = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN') ? userService.getUser(id) : springSecurityService.getCurrentUser()

        try {
            if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) userService.adminEditUser(params, id)
            else userService.editUser(params, user.id)
        } catch (Exception e) {
            render "wrong data"
        }

        redirect(action: "see_colleagues")
    }


    def see_colleagues() {
        [users: userService.getAllUsers(),
        currUser: springSecurityService.loadCurrentUser()]
    }


    def statistics() {
        long id = userService.validateId(params.id) ? params.id as Long : springSecurityService.getCurrentUserId() as Long
        User user = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN') ? userService.getUser(id) : springSecurityService.getCurrentUser()


        [user: user]
    }


    def getStatsAjax() {

        long id = userService.validateId(params.id) ? params.id as Long : springSecurityService.getCurrentUserId() as Long
        User user = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN') ? userService.getUser(id) : springSecurityService.getCurrentUser()

        int month
        int year
        try {
            month = monthNameToInt(params.monthString as String)
            year = params.year as Integer
        } catch (NullPointerException ignored) {
            month = Calendar.getInstance().get(Calendar.MONTH)
            year = Calendar.getInstance().get(Calendar.YEAR)
        }

        response.setContentType("application/json")

        render userService.getStats(user, year, month)

    }


    int monthNameToInt(String monthString) {
        Date date = new SimpleDateFormat("MMMM").parse(monthString)
        Calendar cal = Calendar.getInstance()
        cal.setTime(date)
        return cal.get(Calendar.MONTH)
    }


}




