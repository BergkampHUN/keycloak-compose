<#macro mainLayout active bodyClass>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <title>${msg("accountManagementTitle")}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico">
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script type="text/javascript" src="${url.resourcesPath}/${script}"></script>
        </#list>
    </#if>
</head>
<body class="admin-console user ${bodyClass}">
    <header>
        <nav class="navbar navbar-default navbar-pf" role="navigation">
            <div class="navbar-header">
                <button
                    type="button"
                    class="navbar-toggle"
                    ng-init="navCollapsed = true"
                    ng-click="navCollapsed = !navCollapsed"
                >
                    <span class="sr-only">{{:: 'toggle-navigation' | translate}}</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" onclick="location.href = authUrl"></a>
                <div class="app-name">InfraDOAS</div>
            </div>

            <div class="navbar-collapse navbar-collapse-1">
                <div class="container">
                    <ul class="nav navbar-nav navbar-utility">
                        <#if realm.internationalizationEnabled>
                            <li>
                                <div class="kc-dropdown" id="kc-locale-dropdown">
                                    <a href="#" id="kc-current-locale-link">${locale.current} <b class="caret"></b></a>
                                    <ul>
                                        <#list locale.supported as l>
                                            <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                        </#list>
                                    </ul>
                                </div>
                            <li>
                        </#if>
                        <#if referrer?has_content && referrer.url?has_content><li><a href="${referrer.url}" id="referrer">${msg("backTo",referrer.name)}</a></li></#if>
                        <li><a href="${url.getLogoutUrl()}">${msg("doSignOut")}</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>





    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-9 col-md-10 col-sm-push-3 col-md-push-2 content-area">
                <#if message?has_content>
                    <div class="alert alert-${message.type}">
                        <#if message.type=='success' ><span class="pficon pficon-ok"></span></#if>
                        <#if message.type=='error' ><span class="pficon pficon-error-circle-o"></span></#if>
                        <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>
                <#nested "content">
            </div>
            <div class="bs-sidebar col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left">
                <h2>${msg("configure")}</h2>
                <ul class="nav nav-pills nav-stacked">
                    <li class="<#if active=='account'>active</#if>">
                        <a href="${url.accountUrl}"><span class="pficon pficon-user"></span> ${msg("account")}</a>
                    </li>
                    <#if features.passwordUpdateSupported><li class="<#if active=='password'>active</#if>">
                        <a href="${url.passwordUrl}"><span class="pficon pficon-locked"></span> ${msg("password")}</a>
                    </li></#if>
                    <li class="<#if active=='totp'>active</#if>">
                        <a href="${url.totpUrl}"><span class="pficon pficon-security"></span> ${msg("authenticator")}</a>
                    </li>
                    <#if features.log><li class="<#if active=='log'>active</#if>">
                        <a href="${url.logUrl}"><span class="fa fa-list"></span> ${msg("log")}</a>
                    </li></#if>
                    <li class="<#if active=='sessions'>active</#if>">
                        <a href="${url.sessionsUrl}"><span class="fa fa-clock-o"></span> ${msg("sessions")}</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

</body>
</html>
</#macro>