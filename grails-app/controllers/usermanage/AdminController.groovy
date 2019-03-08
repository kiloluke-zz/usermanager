package usermanage

import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.json.JSONObject

import java.text.SimpleDateFormat

@Secured('ROLE_ADMIN')
class AdminController {

    def userService

    def index(){
        redirect(controller: 'user', action:  'see_colleagues')
    }



    def createUser() {

        try {
            userService.persistUser(params)
        }catch(Exception e){
            render "wrong data"
        }
        redirect(action: "index")
    }

    def deleteUser() {

        User user = userService.getUser(params.id as Long)

        if (!user.authorities.any { it.authority == "ROLE_ADMIN" }) {
            userService.deleteUser(params.id as Long)
        }
        redirect(action: "index")
    }



}
