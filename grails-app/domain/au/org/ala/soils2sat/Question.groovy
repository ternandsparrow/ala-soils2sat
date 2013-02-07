package au.org.ala.soils2sat

class Question {

    String text
    String description

    static constraints = {
        description nullable: true
        text nullable: false, blank: false
    }

}