<!doctype html>
<html>
    <head>
        <r:require module='jqueryui'/>
        <r:require module='bootstrap_responsive'/>
        <meta name="layout" content="detail"/>
        <title>Study Location Visit Summary - ${studyLocationName}</title>
    </head>

    <body>

        <script type="text/javascript">

            $(document).ready(function() {

                $("#btnSelect").click(function(e) {
                    e.preventDefault();
                    $.ajax("${createLink(controller: 'studyLocation', action:'selectStudyLocationVisit', params:[studyLocationVisitId: visitDetail?.studyLocationVisitId, studyLocationName: studyLocationName])}").done(function() {
                        window.location = "${createLink(controller:'studyLocation', action: 'studyLocationVisitSummary', params:[studyLocationVisitId: visitDetail?.studyLocationVisitId, studyLocationName: studyLocationName])}";
                    });

                });

                $("#btnDeselect").click(function(e) {
                    e.preventDefault();
                    $.ajax("${createLink(controller: 'studyLocation', action:'deselectStudyLocationVisit', params:[studyLocationVisitId: visitDetail?.studyLocationVisitId, studyLocationName: studyLocationName])}").done(function() {
                        window.location = "${createLink(controller:'studyLocation', action: 'studyLocationVisitSummary', params:[studyLocationVisitId: visitDetail?.studyLocationVisitId, studyLocationName: studyLocationName])}";
                    });
                });

                $.ajax("${createLink(controller: 'visualisation', action:'studyLocationVisitVisualisations', params:[studyLocationVisitId: visitDetail?.studyLocationVisitId])}").done(function(html) {
                    $("#studyLocationVisitVisualisations").html(html);
                });

                $('a[data-toggle="tab"]').on('shown', function (e) {
                    var tabHref = $(this).attr('href');
                    if (tabHref == "#taxaTab") {
                        $("#taxaTab").html("Retrieving taxa data for study location visit... <sts:spinner/>");
                        $.ajax("${createLink(controller: 'studyLocation', action: 'studyLocationVisitTaxaFragment', params: [studyLocationVisitId: visitDetail.studyLocationVisitId])}").done(function (html) {                            $("#taxaTab").html(html);
                        });
                    } else if (tabHref == "#visitsTab") {
                        refreshVisitsTab();
                    }

                });


            });

        </script>

        <div class="container-fluid">
            <legend>
                <table style="width:100%">
                    <tr>
                        <td>
                            <sts:homeBreadCrumb />
                            <sts:navSeperator/>
                            <sts:studyLocationBreadCrumb studyLocationName="${studyLocationName}" />
                            <sts:navSeperator/>
                            <sts:studyLocationVisitBreadCrumb studyLocationVisitId="${visitDetail.studyLocationVisitId}" nolink="${true}"/>
                        </td>
                        <td>
                            <g:if test="${isSelected}">
                                <button id="btnDeselect" style="margin-right:5px" class="btn btn-small btn-warning pull-right">Deselect study location visit</button>
                            </g:if>
                            <g:else>
                                <button id="btnSelect" style="margin-right:5px" class="btn btn-small btn-info pull-right">Select study location visit</button>
                            </g:else>
                        </td>
                    </tr>
                </table>
            </legend>

            <div class="well well-small">

                <div class="tabbable">

                    <ul class="nav nav-tabs" style="margin-bottom: 0px">
                        <li class="active"><a href="#detailsTab" data-toggle="tab">Details</a></li>
                        <li><a href="#taxaTab" data-toggle="tab">Taxa data</a></li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" id="detailsTab">

                            <h4>Study Location Visit Summary</h4>

                            <table class="table table-bordered table-striped">
                                <tr>
                                    <td>Study Location</td>
                                    <td>${studyLocationDetails?.studyLocationName}</td>
                                </tr>
                                <tr>
                                    <td>Start Date</td>
                                    <td><sts:formatDateStr date="${visitDetail?.visitStartDate}"/></td>
                                </tr>
                                <tr>
                                    <td>End Date</td>
                                    <td><sts:formatDateStr date="${visitDetail?.visitEndDate ?: visitDetail.visitStartDate}"/></td>
                                </tr>
                                <tr>
                                    <td>Observers</td>
                                    <td>${visitDetail?.observers?.collect { it.observerName } ?.join(", ")}</td>
                                </tr>
                                <tr>
                                    <td>Visit Notes</td>
                                    <td>${visitDetail?.visitNotes}</td>
                                </tr>
                                <g:each in="['climaticCondition', 'disturbance', 'drainageType', 'erosionAbundance', 'erosionType', 'locationDescription', 'microrelief', 'soilObservationType', 'surfaceCoarseFragsAbundance', 'surfaceCoarseFragsLithology','surfaceCoarseFragsSize','surfaceCoarseFragsType', 'vegetationCondition']" var="propName">
                                    <tr>
                                        <td>${propName}</td>
                                        <td>${visitDetail?.getAt(propName)}</td>
                                    </tr>
                                </g:each>
                            </table>
                            <h4>Sampling Units</h4>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Sampling Unit</th>
                                    </tr>
                                </thead>
                                <g:each in="${visitDetail?.samplingUnits}" var="su">
                                    <tr>
                                        <td><a href="${createLink(controller: 'studyLocation', action:'samplingUnitDetail', params:[studyLocationVisitId: visitDetail.studyLocationVisitId, samplingUnitTypeId: su.id])}">${su.description}</a> </td>
                                    </tr>
                                </g:each>
                            </table>
                            <div id="studyLocationVisitVisualisations">
                                <sts:spinner />
                            </div>
                        </div>
                        <div class="tab-pane active" id="taxaTab">
                            Foo
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>