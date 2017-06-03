<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="users" type="java.util.Collection<ubb.web.bean.domain.User>" scope="request"/>
<jsp:useBean id="roles" type="java.util.Collection<ubb.web.bean.domain.Role>" scope="request"/>

<div id="user_form_messages">

</div>

<form name="user_form" method="post" action="${pageContext.request.contextPath}/ajax/user/"
      novalidate="novalidate"
      class="form-horizontal">
    <div id="user_form">
        <div class="form-group">
            <label class="col-sm-2 control-label required" for="user_form_id">Id</label>
            <div class="col-sm-10">
                <select id="user_form_id" name="user_form[id]" required="required"
                        class="form-control">
                    <option value="">Select an id</option>
                    <c:forEach items="${users}" var="user">
                        <option value="${user.id}">${user.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <jsp:useBean id="fields" class="java.util.HashMap"/>
        <c:set target="${fields}" property="name" value="Name"/>
        <c:set target="${fields}" property="username" value="Username"/>
        <c:set target="${fields}" property="password" value="Password"/>
        <c:set target="${fields}" property="age" value="Age"/>
        <c:set target="${fields}" property="email" value="Email"/>
        <c:set target="${fields}" property="webPage" value="Web page"/>

        <c:forEach items="${fields}" var="field">
            <div class="form-group">
                <label class="col-sm-2 control-label required" for="user_form_${field.key}">${field.value}</label>
                <div class="col-sm-10">
                    <input type="${field.key == "password" ? "password" : "text"}"
                           id="user_form_${field.key}"
                           name="user_form[${field.key}]"
                           required="required"
                           class="form-control"/>
                </div>
            </div>
        </c:forEach>

        <div class="form-group">
            <label class="col-sm-2 control-label required" for="user_form_role">Role</label>
            <div class="col-sm-10">
                <select id="user_form_role" name="user_form[role]" required="required"
                        class="form-control">
                    <option value="" selected="selected">Select a role</option>
                    <c:forEach items="${roles}" var="role">
                        <option value="${role.name()}">${role.toString()}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <input type="hidden" id="user_form_token" name="user_form[_token]"/>
    </div>

    <div class="row">
        <div class="col-sm-offset-2 col-sm-10">
            <button id="user_form_submit_btn" disabled="disabled" type="submit" value="save"
                    class="btn btn-success">Save
            </button>
            <button id="user_form_reset_btn" type="reset" value="reset" class="btn btn-primary">
                Reset
            </button>
        </div>
    </div>
</form>

<!-- Save confirmation Modal -->
<div id="user_save_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                Save Confirmation
            </div>
            <div class="modal-body">
                You have unsaved changes, do you wish to save user <span id="user_to_save"></span> ?
            </div>
            <div class="modal-footer">
                <button id="user_donnot_save_btn" type="button" class="btn btn-info"
                        data-dismiss="modal">Don't save
                </button>
                <button id="user_confirm_save_btn" type="button" class="btn btn-success"
                        data-dismiss="modal">Continue editing
                </button>
            </div>
        </div>
    </div>
</div>


<script>
    function populateUserFormById(userId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/ajax/get-user/' + userId,
            error: function (req, text, err) {
                console.log(req);
                console.log(text);
                console.log(err);
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
                if (response.status === 'success') {
                    populateForm('user_form', response.user);
                    $('#user_form_submit_btn').attr('disabled', true);
                } else {
                    writeMessage('user_form_messages', 'danger', response.message);
                    var $id = $('#user_form_id');
                    $id.find('option[value=' + userId + ']').remove();
                    hardResetForm('user_form');
                }
            },
            type: 'GET'
        });
    }

    $(document).ready(function () {
        var previousId;
        var $submitBtn = $('#user_form_submit_btn');
        var $idSelect = $('#user_form_id');
        $idSelect.on('focus', function (e) {
            previousId = this.value;
        }).change(function () {
            var id = this.value;
            if (!id) {
                $('#user_form_submit_btn').attr('disabled', false);
                return;
            }

            if ($submitBtn.attr('disabled') !== 'disabled') {
                //has changes so ask permission
                $('#user_donnot_save_btn')
                    .off()
                    .click(function (e) {
                        populateUserFormById(id);
                    });
                $('#user_confirm_save_btn')
                    .off()
                    .click(function (e) {
                        $idSelect.val(previousId);
                    });

                $('#user_to_save').html($('#user_form_name').val());
                $('#user_save_modal').modal();
            } else {
                populateUserFormById(id);
            }
        });

        $('form[name="user_form"]').submit(function (e) {
            e.preventDefault();

        });

        $(':input', 'form[name="user_form"]')
            .bind('keyup change', function (e) {
                if (this.id === 'user_form_id') {
                    return;
                }
                $submitBtn.removeAttr('disabled');
            });
    })
</script>