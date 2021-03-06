%{--
  - ﻿Copyright (C) 2013 Atlas of Living Australia
  - All Rights Reserved.
  -
  - The contents of this file are subject to the Mozilla Public
  - License Version 1.1 (the "License"); you may not use this file
  - except in compliance with the License. You may obtain a copy of
  - the License at http://www.mozilla.org/MPL/
  -
  - Software distributed under the License is distributed on an "AS
  - IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  - implied. See the License for the specific language governing
  - rights and limitations under the License.
  --}%

<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="detail"/>
        <title>Extract Data from Study Location Visits</title>
    </head>

    <body>

        <style type="text/css">
        </style>

        <script type="text/javascript">

            $(document).ready(function () {
            });

        </script>

        <div class="container">
            <legend>
                <table style="width:100%">
                    <tr>
                        <td>
                            <sts:homeBreadCrumb />
                            <sts:navSeperator/>
                            <span class="sts-breadcrumb">Extract Data from selected Study Location Visits</span>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </legend>

            <div class="row">
                <div class="span12">
                    <div class="well well-small">
                        <h4>Extract Data</h4>
                        <p>
                        Click <em>Next</em> to begin the process of creating a citable data extract.
                        </p>
                        <p>
                            This process will guide you through the following steps:
                            <ul>
                                <li>Confirming/selecting which visits to export</li>
                                <li>Confirming/selecting which sampling units to export</li>
                                <li>Confirming/entering basic citation details</li>
                                <li>The extraction and packaging of the selected data, including the minting and publication of a unique DOI for this extract.</li>
                            </ul>
                        </p>
                    </div>
                    <g:link class="btn btn-small" event="cancel">Cancel</g:link>
                    <g:link class="btn btn-small btn-primary" event="continue">Next&nbsp;<i class="icon-chevron-right icon-white"></i></g:link>
                </div>
            </div>
        </div>
    </body>
</html>
