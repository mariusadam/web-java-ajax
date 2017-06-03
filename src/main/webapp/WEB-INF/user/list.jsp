<div id="user_list_messages"></div>
<table class="table table-hover table-bordered" id="list-users-table">
    <thead>
    <tr>
        <th>#Id</th>
        <th>Name</th>
        <th>Username</th>
        <th>Email</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<!-- Delete confirmation Modal -->
<div id="user_delete_modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                Delete Confirmation
            </div>
            <div class="modal-body">
                Are you sure you want to delete user with id <span id="user_to_delete"></span> ?
            </div>
            <div class="modal-footer">
                <button id="user_cancel_delete_btn" type="button" class="btn btn-info"
                        data-dismiss="modal">Cancel
                </button>
                <button id="user_confirm_delete_btn" type="button" class="btn btn-danger"
                        data-dismiss="modal">Delete
                </button>
            </div>
        </div>
    </div>
</div>