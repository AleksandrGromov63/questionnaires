<#import "common.ftlh" as p>
<@p.page>
    <div class="wrapper">
        <div class="main-form">
            <div class="face">
                <div class="content">
                    <h2>Sign in</h2>
                    <form action="/login" method="post">
                        <div class="field-wrapper">
                            <input type="text" name="username" placeholder="username">
                            <label>username</label>
                        </div>
                        <div class="field-wrapper">
                            <input type="password" name="password" placeholder="password">
                            <label>password</label>
                        </div>
                        <div class="field-wrapper">
                            <input type="submit" value="Log in">
                        </div>
                        <a href="/registration">
                            <span class="signup">Not a user? Sign up</span>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@p.page>



<#--
<@security.authorize access="!isAuthenticated()">
    <div class="ui-menu-item-wrapper">
        <a href="/login" class="">
            <button class="btn-primary">Log in</button>
        </a>
        <a href="/registration" class="">
            <button class="btn-secondary">Sign in</button>
        </a>
    </div>
</@security.authorize>
<@security.authorize access="isAuthenticated()">
    <a href="/logout" class="">
        <button class="btn-primary">Log out</button>
    </a>
</@security.authorize>
<@security.authorize access="hasRole('USER')">
    <a href="/user/questionnaires" class="">
        <button class="btn-primary">Choose a questionnaire</button>
    </a>
</@security.authorize>
<@security.authorize access="hasRole('ADMIN')">
    <a href="/admin/constructor">Создать анкету</a>
    <a href="/admin/questionnaires">Редактировать анкету</a>
    <a href="/admin/questionnaires">Пройти опрос</a>>
    <a href="/admin/allUsers">Ответы пользователей</a>
</@security.authorize>-->
