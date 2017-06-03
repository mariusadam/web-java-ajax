function bindFormButtons(formName) {
    $(':input', 'form[name="' + formName + '"]')
        .bind('keyup change', function (e) {
            if (this.id == formName + '_id') {
                return;
            }
            $('#football_team_submit_btn').removeAttr('disabled');
        });
}

function trySaveBeforeReload(formName, previousId, onModalClose) {
    if ($('#football_team_submit_btn').attr('disabled') == 'disabled') {
        // no modifications so do not ask to save
        onModalClose();
        return;
    }

    $('#football_team_confirm_save_btn').click(function () {
//                var $idElement = $('#' + formName + '_id');
//                var currentId = $idElement.val();
        var formValues = $('form[name="' + formName + '"]').serializeArray();
        for (var i = 0; i < formValues.length; i++) {
            if (formValues[i].name == formName + '[id]') {
                formValues[i].value = previousId;
                break;
            }
        }

        saveTeamAjax(formName, $.param(formValues));
    });

    var $confirmModal = $('#football_team_save_modal');
    $confirmModal.on("hidden.bs.modal", onModalClose);
    $confirmModal.modal();
}

function getTeamAjax(formName) {
    var previousId;

    $('#' + formName + '_id').on('focus', function (e) {
        previousId = this.value;
    }).change(function () {
        var id = this.value;
        console.log(id);
        if (!id) {
            $('#football_team_submit_btn').attr('disabled', false);
            return;
        }
        //TODO change this so that only asks to discard changes
        // and not try to save because it will cause chaos
        trySaveBeforeReload(formName, previousId, function () {
            // do a get to retrieve team
            $.ajax({
                url: teamUrl(id),
                error: function (req, text, err) {
                    console.log(req);
                    console.log(text);
                    console.log(err);
                },
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    if (data.type == 'success') {
                        populateForm(formName, data.team);
                        $('#football_team_submit_btn').attr('disabled', true);
                    } else {
                        writeMessage('football_team_form_messages', data.type, data.msg);
                        $('#football_team_form_id').find('option[value=' + id + ']').remove();
                        // remove id form select
                        resetForm('football_team_form');
                    }
                },
                type: 'GET'
            });
        });
    })
}

function teamUrl(id) {
    return '/index_dev.php/teams/0' + id;
}

function saveTeamAjax(formName, formData) {
    // populate create form
    $.ajax({
        url: '/index_dev.php/teams/new',
        error: function (req, text, err) {
            console.log(req);
            console.log(text);
            console.log(err);
        },
        data: formData,
        success: function (data) {
            $('#' + formName + '_wrapper')
                .empty()
                .append(data);
            initializeBindings(formName);
        },
        type: 'POST'
    });
}

function postFormAjax(formName) {
    $('form[name="' + formName + '"]').submit(function (e) {
        e.preventDefault();
        saveTeamAjax(formName, $(this).serialize());
    });
}

function bindResetButton() {
    $('#football_team_reset_btn').click(function (e) {
        e.preventDefault();
        resetForm('football_team_form');
    });
}

function getFormAjax(formName) {
    // populate create form
    $.ajax({
        url: '/index_dev.php/teams/new',
        error: function (req, text, err) {
            console.log(req);
            console.log(text);
            console.log(err);
        },
        success: function (data) {
            $('#' + formName + '_wrapper').empty().append(data);
            initializeBindings(formName);
        },
        type: 'GET'
    });
}

function getAllTeams() {
    // populate create form
    $.ajax({
        url: '/index_dev.php/teams',
        error: function (req, text, err) {
            console.log(req);
            console.log(text);
            console.log(err);
        },
        success: function (data) {
            if (data.success) {
                populateTeamsTable('list-teams-table', data.teams);
            } else {
                // TODO alert messages
                console.log(data);
            }
        },
        type: 'GET'
    });
}


function formDeleteHandler(type, msg, deletedId) {
    writeMessage('football_team_form_messages', type, msg);
    if (type == 'success') {
        $('#football_team_form_id').find('option[value=' + deletedId + ']').remove();
        // remove id form select
        resetForm('football_team_form');
    }
}

function bindFormDeleteBtn() {
    var $btn = $('#football_team_delete_btn');
    var $teamIdElement = $('#football_team_form_id');
    $btn.click(function (e) {
        e.preventDefault();
        if (!$teamIdElement.val()) {
            formDeleteHandler('danger', 'You have not selected and id.');
            return;
        }

        $('#team_to_delete_it')
            .empty()
            .append($teamIdElement.val());
        $('#football_team_delete_modal').modal();

        deleteTeamAjax(formDeleteHandler, $teamIdElement.val());
    });
}

function deleteTeamAjax(successHandler, teamId) {
    var $confirmBtn = $('#football_team_confirm_delete_btn');
    // remove any previous events
    $confirmBtn.off();
    $confirmBtn.click(function (e) {
        $.ajax({
            url: '/teams/' + teamId,
            error: function (req, text, err) {
                console.log(req);
                console.log(text);
                console.log(err);
            },
            success: function (data) {
                successHandler(data.type, data.msg, teamId);
            },
            type: 'DELETE'
        });
    });
}

function initializeBindings(teamFormName) {
    postFormAjax(teamFormName);
    getTeamAjax(teamFormName);
    getAllTeams();
    bindFormDeleteBtn();
    bindResetButton();
    bindFormButtons(teamFormName)
}