<#import "common.ftlh" as c>
<@c.page>
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home"
                    type="button" role="tab" aria-controls="pills-home" aria-selected="true">Home
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pills-create-tab" data-bs-toggle="pill" data-bs-target="#pills-create"
                    type="button" role="tab" aria-controls="pills-create" aria-selected="false">Create
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pills-edit-tab" data-bs-toggle="pill" data-bs-target="#pills-edit"
                    type="button" role="tab" aria-controls="pills-edit" aria-selected="false">Edit
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pills-take-the-survey-tab" data-bs-toggle="pill"
                    data-bs-target="#pills-take-the-survey"
                    type="button" role="tab" aria-controls="pills-take-the-survey" aria-selected="false">Take the survey
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <a href="/logout">
                <button class="nav-link" id="logout-tab" data-bs-toggle="pill"
                        type="button" role="tab" aria-selected="false">Logout
                </button>
            </a>
        </li>
    </ul>
    <div class="tab-content" id="pills-tabContent">
        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab"
             tabindex="0">
            <h2>User responses:</h2>
            <#list allUsers as user>
                <h3>${user.username}</h3>
            </#list>
            <h3>Questionnaires:</h3>
            <#list allQuestionnaires as ques>
                <h3>${ques.name}</h3>
                <h4>Questions:</h4>
                <#list ques.questions as questions>
                    <h4>${questions.name}</h4>
                </#list>
            </#list>
        </div>
        <div class="tab-pane fade" id="pills-create" role="tabpanel" aria-labelledby="pills-create-tab" tabindex="0">
            <div class="questionnaire" id="sup">
                <div class="footer-create">
                    <a href="/admin">
                        <button class="btn-warning home-btn" <#--id="home-btn"-->>Home</button>
                    </a>
                    <button class="btn-primary add-question" id="qqq"<#--id="add-question"-->>Add question</button>
                </div>
                <input type="text" class="form-control form-control-lg questionnaireName" name="questionnaireName"
                       placeholder="name of the questionnaire" id="questionnaireName">
                <div class="questions"></div>
                <input type="submit" value="Save" class="save-questionnaire" onclick="createQuestionnaire()">
                <button onclick="returnState()" id="aaa" class="btn-primary">Могучая</button>
            </div>
            <script>

                 /* $(document).on('click', '#qqq', function (e){
                      let questionWrapper = document.createElement('div')
                      console.log(questionWrapper)
                      questionWrapper.classList.add('question-wrapper')

                      document.querySelector('.questions').append(questionWrapper)
                      questionsCounter++

                      createQuestion(questionWrapper)
                  });

                function returnState() {
                    $('#pills-create').on('click', '#aaa', function (e) {
                        e.preventDefault()
                        $('#pills-create').load(location.href + ' #sup')
                    })
                    /!* $('#pills-create').load('#pills-create > *')*!/
                    //$('#sup').html(document.createElement('div'))
                }*/



               // const questions = document.querySelector('.questions')
                const addQuestionBtn = document.querySelector('.add-question')

                let data = {}

                let questionsCounter = 0

                function createQuestionnaire() {

                    data.questionnaireName = document.querySelector('#questionnaireName').value
                    data.questionsCount = getQuestionsCount()

                    let allQuestions = document.querySelectorAll("[id^=question№]:not([id*='answer№'])")
                    let allAnswers = document.querySelectorAll('[id*=question№][id*=answer№]')

                    Array.from(allQuestions).forEach((element) => {
                        let tempID = element.id
                        let answerArray = []

                        Array.from(allAnswers).forEach((el) => {
                            if (el.id.toString().startsWith(tempID.toString())) {
                                answerArray.push(el.value)
                            }
                        })
                        data[element.value] = answerArray
                    })

                    $.ajax({
                        type: 'POST',
                        url: '/admin/constructor',
                        data: JSON.stringify(data),
                        async: false, /*special for Google Chrome*/
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'html',
                        success: function () {
                            window.location.href = '/admin';
                        }
                    })
                };

               /* addQuestionBtn.addEventListener('click', () => {

                    let questionWrapper = document.createElement('div')
                    questionWrapper.classList.add('question-wrapper')

                    questions.append(questionWrapper)

                    questionsCounter++

                    createQuestion(questionWrapper)

                });*/

                const getQuestionsCount = () => {
                    return document.querySelectorAll('.question-wrapper').length;
                };

                const createQuestion = (questionWrapper) => {

                    let answerCounter = 0
                    //const wrapper = document.createElement('div')
                    const inputQuestion = document.createElement('input')
                    const inputAnswerOne = document.createElement('input')
                    const inputAnswerTwo = document.createElement('input')
                    const deleteBtn = document.createElement('button')
                    const addAnswerBtn = document.createElement('button');

                    const questionsCount = getQuestionsCount()

                    inputQuestion.classList.add('form-control', 'field')
                    inputQuestion.id = 'question№' + questionsCounter
                    inputQuestion.type = 'text'
                    inputQuestion.placeholder = 'Question'

                    answerCounter++

                    inputAnswerOne.classList.add('form-control', 'field', 'field-answer')
                    inputAnswerOne.id = 'question№' + questionsCount + 'answer№' + answerCounter
                    inputAnswerOne.type = 'text'
                    inputAnswerOne.placeholder = 'Answer'

                    answerCounter++

                    inputAnswerTwo.classList.add('form-control', 'field', 'field-answer')
                    inputAnswerTwo.id = 'question№' + questionsCount + 'answer№' + answerCounter
                    inputAnswerTwo.type = 'text'
                    inputAnswerTwo.placeholder = 'Answer'

                    deleteBtn.classList.add('btn-warning', 'del-btn')
                    deleteBtn.innerText = 'Delete question'
                    //deleteBtn.id = 'del-btn'

                    addAnswerBtn.classList.add('btn-primary')
                    addAnswerBtn.innerText = 'Add answer'

                    const changeQuestion = document.createElement('div')
                    changeQuestion.classList.add('change-question')

                    changeQuestion.append(deleteBtn, addAnswerBtn)

                    questionWrapper.append(changeQuestion)
                    questionWrapper.append(inputQuestion)
                    questionWrapper.append(inputAnswerOne)
                    questionWrapper.append(inputAnswerTwo)


                    deleteBtn.addEventListener('click', () => {

                        /* if (questionWrapper.querySelectorAll('.question').length === 1) {
                             questionWrapper.remove();
                             return;
                         }*/
                        questionWrapper.remove();
                        questionsCounter--
                    })

                    addAnswerBtn.addEventListener('click', () => {
                        let divAnswer = document.createElement('div')
                        let answer = document.createElement('input')
                        let delAnswerButton = document.createElement('button')

                        divAnswer.classList.add('new-answer')

                        answerCounter++

                        answer.classList.add('form-control', 'field', 'answer', 'field-answer')
                        answer.id = 'question№' + questionsCount + 'answer№' + answerCounter
                        answer.type = 'text'
                        answer.placeholder = 'Answer'

                        delAnswerButton.type = 'btn-warning'
                        delAnswerButton.classList.add('btn-warning')
                        delAnswerButton.innerText = 'Delete answer'

                        divAnswer.append(answer, delAnswerButton)

                        /*document.querySelector('#del-btn').before(divAnswer)*/
                        questionWrapper.append(divAnswer) /*<-------"Это Не Верно. Надо Вставить перед кнопкой удаления всего блока вопроса*/


                        delAnswerButton.addEventListener('click', () => {
                            divAnswer.remove()
                            answerCounter--
                        })
                    })
                    return questionsCount;
                }

            </script>
        </div>
        <div class="tab-pane fade" id="pills-edit" role="tabpanel" aria-labelledby="pills-edit-tab" tabindex="0">
            <h2>Available Questionnaires(Edit):</h2>
            <#list allQuestionnaires as ques>
                <div class="edit-questionnaire">
                    <input type="text" id="name-que-${ques.name}" value="${ques.name}" disabled>
                    <input type="hidden" id="ques-id-${ques.id}" value="${ques.id}">
                    <button onclick="getQuestionnaire(${ques.id}, this)" class="btn-primary">Edit</button>
                    <button onclick="deleteQuestionnaire(${ques.id}, this)" class="btn-primary">Delete</button>
                </div>
            </#list>

            <script>
                function getQuestionnaire(idQuest, event) {
                    let questionnaireFromDB = 0

                    $.ajax({
                        method: 'GET',
                        url: '/admin/questionnaires/' + idQuest,
                        async: false,
                        dataType: 'json',
                        success(data, textStatus, jqXHR) {
                            /*window.location.href = '/admin'*/
                            questionnaireFromDB = JSON.parse(jqXHR.responseText)
                            console.log(questionnaireFromDB)
                        }
                    })

                    const divQuestionnaire = document.createElement('div')
                    divQuestionnaire.classList.add('questionnaire')

                    const footerQuestionnaire = document.createElement('div')
                    footerQuestionnaire.classList.add('footer-create')

                    const homeLink = document.createElement('a')
                    homeLink.href = '/admin'

                    const homeBtn = document.createElement('button')
                    homeBtn.classList.add('btn-warning', 'home-btn')
                    homeBtn.innerText = 'Home'

                    homeLink.append(homeBtn)

                    let addQuestionButton = document.createElement('button')
                    addQuestionButton.innerText = 'Add question'
                    addQuestionButton.classList.add('btn-primary', 'add-question')

                    footerQuestionnaire.append(homeLink, addQuestionButton)

                    const questionnaireName = document.createElement('input')
                    questionnaireName.classList.add('form-control', 'form-control-lg', 'questionnaireName')
                    questionnaireName.type = 'text'
                    questionnaireName.name = 'questionnaireName'
                    questionnaireName.value = questionnaireFromDB.name

                    const divQuestions = document.createElement('div')
                    divQuestions.classList.add('questions')

                    addQuestionButton.addEventListener('click', () => {

                        let questionWrapper = document.createElement('div')
                        questionWrapper.classList.add('question-wrapper')

                        divQuestions.append(questionWrapper)

                        questionsCounter++

                        createQuestion(questionWrapper)

                    });

                    const saveChangesBtn = document.createElement('input')
                    saveChangesBtn.type = 'submit'
                    saveChangesBtn.value = 'Save'
                    saveChangesBtn.classList.add('save-questionnaire')

                    divQuestionnaire.append(footerQuestionnaire, questionnaireName, divQuestions, saveChangesBtn)

                    let allQuestions = questionnaireFromDB.questions

                    allQuestions.forEach((element) => {
                        let divQuestionWrapper = document.createElement('div')
                        divQuestionWrapper.classList.add('question-wrapper')

                        let divChangeQuestion = document.createElement('div')
                        divChangeQuestion.classList.add('change-question')

                        let deleteQuestionBtn = document.createElement('button')
                        deleteQuestionBtn.classList.add('btn-warning', 'del-btn')
                        deleteQuestionBtn.innerText = 'Delete question'

                        let addAnswerButton = document.createElement('button')
                        addAnswerButton.classList.add('btn-primary')
                        addAnswerButton.innerText = 'Add answer'

                        divChangeQuestion.append(deleteQuestionBtn, addAnswerButton)

                        divQuestionWrapper.append(divChangeQuestion)

                        let inputQuestion = document.createElement('input')
                        inputQuestion.type = 'text'
                        inputQuestion.placeholder = 'Question'
                        inputQuestion.classList.add('form-control', 'field')
                        inputQuestion.value = element.name

                        divQuestionWrapper.append(inputQuestion)

                        for (let i = 0; i < element.answers.length; i++) {

                            if (i > 1) {
                                let divAnswer = document.createElement('div')
                                divAnswer.classList.add('new-answer')

                                let answer = document.createElement('input')
                                answer.type = 'text'
                                answer.placeholder = 'Answer'
                                answer.classList.add('form-control', 'field', 'answer', 'field-answer')
                                answer.value = element.answers[i].name

                                let delAnswerButton = document.createElement('button')
                                delAnswerButton.classList.add('btn-warning')
                                delAnswerButton.innerText = 'Delete answer'

                                divAnswer.append(answer, delAnswerButton)

                                divQuestionWrapper.append(divAnswer)
                            } else {
                                let inputAnswer = document.createElement('input')
                                inputAnswer.type = 'text'
                                inputAnswer.placeholder = 'Answer'
                                inputAnswer.classList.add('form-control', 'field', 'field-answer')
                                inputAnswer.value = element.answers[i].name

                                divQuestionWrapper.append(inputAnswer)
                            }
                        }

                        divQuestions.append(divQuestionWrapper)
                    })
                    let elementsForDelete = document.getElementsByClassName('edit-questionnaire')

                    while (elementsForDelete.length > 0) {
                        elementsForDelete[0].parentNode.removeChild(elementsForDelete[0])
                    }

                    document.getElementById('pills-edit').append(divQuestionnaire)
                }

                function deleteQuestionnaire(idQuest, event) {
                    $.ajax({
                        method: 'POST',
                        url: 'admin/questionnaires/' + idQuest,
                        async: false
                    })
                }
            </script>
        </div>
        <div class="tab-pane fade" id="pills-take-the-survey" role="tabpanel"
             aria-labelledby="pills-take-the-survey-tab"
             tabindex="0">..D.
        </div>
    </div>
<#--   <script>
       const triggerTabList = document.querySelectorAll('#pills-profile-tab')
       triggerTabList.forEach(triggerEl => {
           const tabTrigger = new bootstrap.Tab(triggerEl)

           triggerEl.addEventListener('click', event => {
               event.preventDefault()
               tabTrigger.show()
           })
       })
   </script>-->
</@c.page>