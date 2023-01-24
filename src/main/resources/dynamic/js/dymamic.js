$(document).on('click', '#qqq', function () {
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
    /* $('#pills-create').load('#pills-create > *')*/
    //$('#sup').html(document.createElement('div'))
}


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
            console.log('Успешно!!!')
            window.location.href = '/admin'
        }
    })
}

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

        questionWrapper.append(divAnswer)

        delAnswerButton.addEventListener('click', () => {
            divAnswer.remove()
            answerCounter--
        })
    })
    return questionsCount;
}


function getQuestionnaire(idQuest, event) {
    let questionnaireFromDB = 0

    $.ajax({
        method: 'GET',
        url: '/admin/questionnaires/' + idQuest,
        async: false,
        dataType: 'json',
        success(data, textStatus, jqXHR) {
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
