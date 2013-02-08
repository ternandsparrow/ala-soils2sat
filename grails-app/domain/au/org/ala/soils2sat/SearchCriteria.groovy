package au.org.ala.soils2sat

class SearchCriteria {

    SearchCriteriaDefinition criteriaDefinition
    String value
    String displayUnits

    static constraints = {
        value nullable: true
        displayUnits nullable: true
    }

}
