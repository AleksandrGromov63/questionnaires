<#import "common.ftlh" as c>
<@c.page>
    <div class="wrapper">
        <div class="main-form">
            <div class="face">
                <div class="content">
                    <h2>Sign up</h2>
                    <form action="/registration" method="post">
                        <div class="field-wrapper">
                            <input type="text" name="username" placeholder="username">
                            <label>username</label>
                        </div>
                        <div class="field-wrapper">
                            <input type="password" name="password" placeholder="password">
                            <label>password</label>
                        </div>
                        <div class="field-wrapper">
                            <input type="password" name="passwordConfirm" placeholder="passwordConfirm">
                            <label>passwordConfirm</label>
                        </div>
                        <div class="field-wrapper">
                            <input type="submit" value="Sign up">
                        </div>
                        <a href="/login">
                            <span class="signup">Already a user? Sign in</span>
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@c.page>
