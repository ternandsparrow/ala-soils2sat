<html>
<head>
	<meta name='layout' content='main'/>
	<title><g:message code="springSecurity.login.title"/></title>
    <meta name="layout" content="soils2sat"/>

	<style type='text/css' media='screen'>
	</style>

</head>

<body>
<div id='login' class="container-fluid">
	<div class="row-fluid">
        <div class="hero-unit">
            <h3><g:message code="springSecurity.login.header"/></h3>

            <g:if test='${flash.message}'>
                <div class="alert alert-error">
                    <div class='login_message'>${flash.message}</div>
                </div>
            </g:if>

            <form class="form-horizontal" action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
                <div class="control-group">
                    <label class="control-label" for='username'><g:message code="springSecurity.login.username.label"/>:</label>
                    <div class="controls">
                        <input type='text' name='j_username' id='username' placeholder="Email"/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for='password'><g:message code="springSecurity.login.password.label"/>:</label>
                    <div class="controls">
                        <input type='password' name='j_password' id='password' placeholder="password" />
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <label class="checkbox">
                            <input type="checkbox" name="${rememberMeParameter}" id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>>
                            <g:message code="springSecurity.login.remember.me.label"/>
                        </label>
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input class="btn btn-primary" type='submit' id="submit" value='${message(code: "springSecurity.login.button")}'/>
                    </div>
                </div>
                <div>
                    Not registered? Click <a href="${createLink(controller: 'login', action: 'register')}">here.</a>
                </div>
            </form>
        </div>
	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>