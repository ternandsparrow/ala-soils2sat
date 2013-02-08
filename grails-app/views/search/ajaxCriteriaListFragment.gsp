<%@ page import="au.org.ala.soils2sat.CriteriaValueType" %>
<div>
    <g:if test="${userSearch?.criteria}">
        <h5>Each of the following criteria must be met:</h5>
        <g:each in="${userSearch.criteria}" var="criteria">
            <div class="alert alert-info" style="color: black">
                <table style="width: 100%">
                    <tr searchCriteriaId="${criteria.id}">
                        <td>
                            <strong>${criteria.criteriaDefinition.name}</strong>&nbsp;
                            ${au.org.ala.soils2sat.SearchCriteriaUtils.format(criteria, "strong")}
                        </td>
                        <td>
                            <button type="button" class="btn btn-mini pull-right btnDeleteCriteria"><i class="icon-remove"></i></button>
                        </td>
                    </tr>
                </table>

            </div>
        </g:each>
    </g:if>
</div>

<script type="text/javascript">

    $(".btnDeleteCriteria").click(function(e) {
        e.preventDefault();
        var criteriaId = $(this).parents("tr[searchCriteriaId]").attr("searchCriteriaId");
        if (criteriaId) {
            $.ajax("${createLink(action:'deleteSearchCriteria', params:[userSearchId: userSearch.id])}&searchCriteriaId=" + criteriaId).done(function(results) {
                renderCriteria();
            });
        }
    });

</script>