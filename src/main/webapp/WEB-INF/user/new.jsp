<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="user_form_messages">

</div>

<form name="user_form" method="post" action="${pageContext.request.contextPath}/user/new"
      novalidate="novalidate"
      class="form-horizontal">
    <div id="user_form">
        <div class="form-group">
            <label class="col-sm-2 control-label required" for="user_form_id">Id</label>
            <div class="col-sm-10">
                <select id="user_form_id" name="user_form[id]" required="required"
                        class="form-control">

                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label required" for="user_form_name">Name</label>
            <div class="col-sm-10">
                <input type="text"
                       id="user_form_name"
                       name="user_form[name]"
                       required="required"
                       class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label required" for="user_form_username">Username</label>
            <div class="col-sm-10">
                <input type="text"
                       id="user_form_username"
                       name="user_form[username]"
                       required="required"
                       class="form-control"/>
            </div>
        </div>

        <input type="hidden" id="user_form_token" name="user_form[_token]"/>
    </div>

    <div class="row">
        <div class="col-sm-offset-2 col-sm-10">
            <button id="user_submit_btn" disabled="disabled" type="submit" value="save"
                    class="btn btn-success">Save
            </button>
            <%--<button id="user_delete_btn" type="reset" value="delete"--%>
            <%--class="btn btn-danger team-delete-btn">Delete--%>
            <%--</button>--%>
            <button id="user_reset_btn" type="reset" value="reset" class="btn btn-primary">
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
                You have unsaved changes, do you wish to save ? <span id="user_to_save"></span> ?
            </div>
            <div class="modal-footer">
                <button id="user_donnot_save_btn" type="button" class="btn btn-info"
                        data-dismiss="modal">Don't save
                </button>
                <button id="user_confirm_save_btn" type="button" class="btn btn-success"
                        data-dismiss="modal">Save
                </button>
            </div>
        </div>
    </div>
</div>
