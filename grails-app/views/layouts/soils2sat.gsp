<%@ page import="grails.util.Environment" %>
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

<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <r:require module="jquery"/>
        <r:require module="jquery-ui" />

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="Soils2Sat"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="https://www.ala.org.au/wp-content/themes/ala2011/images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
        <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'soils2sat.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: '/jqwidgets/styles', file: 'jqx.base.css')}" type="text/css"/>

        <g:layoutHead/>
        <r:require module="bootstrap"/>
        <r:require module="application"/>
        <r:layoutResources/>
        <Style type="text/css">

        body {
            padding-top: 60px;
            padding-bottom: 70px;
        }

        .footer {
            height: 59px;
            bottom: 0px;
            position: fixed;
            width: 100%;
            background-color: #efefef;
        }

        .footer img {
            max-width: inherit;
        }

        #buttonBar .btn {
            margin-top: 0px;
        }

        .environmentOverlay {
            float: left;
            position: absolute;
            font-size: 12px;
            color: red;
        }

        </Style>

        <script type="text/javascript">

            $(document).ready(function (e) {

                $.ajaxSetup({ cache: false });

                $("#btnLogout").click(function (e) {
                    window.location = "${createLink(controller: 'logout', action:'index')}";
                });

                $("#btnAdministration").click(function (e) {
                    window.location = "${createLink(controller: 'admin')}";
                });

                $("#btnProfile").click(function (e) {
                    window.location = "${createLink(controller: 'userProfile')}";
                });

            });

            function displayLayerInfo(layerName) {
                showModal({
                    url: "${createLink(controller: 'map', action:'layerInfoFragment', params:[dummy:1])}&layerName=" + layerName,
                    title: "Layer details - " + layerName,
                    height: 520,
                    width: 800
                });
                return true;
            }

        </script>

    </head>

    <body style="overflow: auto">
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">

                <div class="container-fluid">
                    <a class="brand" href="${createLink(controller: 'map', action: 'index')}" style="padding-bottom: 0; padding-top: 0">
                        <img src="${resource(dir:'/images', file:'Soils-to-Satellites_40px.png')}" />
                        <g:if test="${["development", "test"].contains(Environment.current.name)}">
                            <span class="environmentOverlay">
                                ${Environment.current.name?.toUpperCase()}&nbsp; Environment
                            </span>
                        </g:if>
                    </a>
                    <div class="nav-collapse collapse">
                        <div class="navbar-text pull-right">
                            <span id="buttonBar">
                                <sec:ifLoggedIn>
                                    <sec:username/>&nbsp;<button class="btn btn-small" id="btnLogout"><i class="icon-off"></i>&nbsp;Logout</button>
                                    <button class="btn btn-small btn-info" id="btnProfile"><i class="icon-user icon-white"></i>&nbsp;My Profile</button>
                                </sec:ifLoggedIn>
                                <sts:ifAdmin>
                                    <button class="btn btn-warning btn-small" id="btnAdministration"><i class="icon-cog icon-white"></i>&nbsp;Administration</button>
                                </sts:ifAdmin>
                                <g:pageProperty name="page.buttonBar"/>
                            </span>
                        </div>
                        <sts:navbar active="${pageProperty(name: 'page.topLevelNav')}"/>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>
        <g:layoutBody/>
        <div class="footer" role="contentinfo">
            <table style="width: 100%">
                <tr>
                    <td>
                        <img src="${resource(dir: '/images', file: 'S2S-banner.png')}" style="height: 59px"/>
                    </td>
                    <td style="">
                        <small style="font-size: 0.8em">
                        This project is supported by the <a href="http://www.ands.org.au/" target="_blank">Australian National Data Service (ANDS)</a>. ANDS is supported by the Australian Government through the National Collaborative Research Infrastructure Strategy Program and the Education Investment Fund (EIF) Super Science Initiative
                        </small>
                    </td>
                </tr>
            </table>
        </div>

        <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
        <g:javascript library="application"/>
        <r:layoutResources/>

        <g:if test="${!["development", "test"].contains(Environment.current.name)}">
            <script type="text/javascript">

                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-4355440-1']);
                _gaq.push(['_setDomainName', 'ala.org.au']);
                _gaq.push(['_trackPageview']);

                (function() {
                    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
            </script>
        </g:if>
    </body>
</html>