import usermanage.Country
import usermanage.Role
import usermanage.User
import usermanage.UserRole

class BootStrap {

    def init = { servletContext ->


        def userRole = Role.findOrSaveWhere(authority: 'ROLE_USER')

        def adminRole = Role.findOrSaveWhere(authority: 'ROLE_ADMIN')

        def ukraine = Country.findOrSaveWhere(name: 'Ukraine').save(flush: true, failOnError: true)
        def germany = Country.findOrSaveWhere(name: "Germany").save(flush: true, failOnError: true)
        def usa = Country.findOrSaveWhere(name: "USA").save(flush: true, failOnError: true)
        def nicaragua = Country.findOrSaveWhere(name: "Nicaragua").save(flush: true, failOnError: true)
        def albania = Country.findOrSaveWhere(name: "Albania").save(flush: true, failOnError: true)
        def swiss = Country.findOrSaveWhere(name: "Switzerland").save(flush: true, failOnError: true)
        def uganda = Country.findOrSaveWhere(name: "Uganda").save(flush: true, failOnError: true)
        def cotdv = Country.findOrSaveWhere(name: "Cote d'IVoire").save(flush: true, failOnError: true)
        def poland = Country.findOrSaveWhere(name: "Poland").save(flush: true, failOnError: true)


        def user = User.findOrSaveWhere(username: 'admin', password: 'password', firstName: "Mati", lastName: "Johns",
                country: ukraine).save(flush: true, failOnError: true)
        def user2 = User.findOrSaveWhere(username: 'user', password: 'password', firstName: "Alex", lastName: "Johnson", country: uganda).save(flush: true, failOnError: true)


        UserRole.create(user2, userRole)
        UserRole.create(user, adminRole)

    }
    def destroy = {
    }
}
