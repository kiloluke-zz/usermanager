package usermanage

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class UserService {

    User getUser(Long id) {
        return User.get(id)
    }

    def getAllUsers() {
        return User.all
    }


    def adminEditUser(GrailsParameterMap params, Long id) {
        String countryString = params.country
        User userToUpdate = User.get(id)
        Country country = Country.findByName(countryString)
        println(country.name)
        userToUpdate.username = params.username
        if (params.password.length() > 0) {
            userToUpdate.password = params.password
        }
        userToUpdate.firstName = params.firstName
        userToUpdate.lastName = params.lastName
        userToUpdate.setCountry(country)

        println(userToUpdate)
        if (userToUpdate.hasErrors()){
            println(userToUpdate.errors)
        }
        userToUpdate.save(failOnError: true, flush: true)
    }

    def editUser(GrailsParameterMap params, Long id) {
        println(params.country)
        String countryString = params.country

        User userToUpdate = User.get(id)
        Country country = Country.findByName(countryString)
        userToUpdate.username = params.username
        userToUpdate.firstName = params.firstName
        userToUpdate.lastName = params.lastName
        userToUpdate.setCountry(country)
        userToUpdate.save(failOnError: true, flush: true)
    }

    def persistUser(GrailsParameterMap params) {

        Role userRole = Role.findByAuthority("ROLE_USER")
        String countryString = params.country
        println(params)
        Country country = Country.findByName(countryString)
        def user = new User(username: params.username, password: params.password,
                firstName: params.firstName,  lastName: params.lastName, country: country)
        user.save(failOnError: true, flush: true)
        println(user)
        UserRole.create(user, userRole)

    }

    def deleteUser(Long id) {
        User user = getUser(id)
        UserRole.remove(user, Role.findByAuthority("ROLE_USER"))
        user.delete()
    }


    boolean validateId(Object id) {
        if(id <= 0) {
            return false
        }
        long idCheck
        try {
            idCheck = Long.parseLong(id)
            return true
        } catch (NumberFormatException ignored) {
            return false
        } catch (NullPointerException ignored) {
            return false
        }

    }


}
