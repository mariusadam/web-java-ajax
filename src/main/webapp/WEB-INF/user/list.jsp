<div id="user_list_messages"></div>
<table class="table table-hover table-bordered" id="list-users-table">
    <thead>
    <tr>
        <th>#Id</th>
        <th>Name</th>
        <th>Username</th>
        <th>Email</th>
        <th>Age</th>
        <th>Web page</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<div class="text-center">
    <form name="load_users_form">
        <button type="submit" class="btn btn-primary btn-lg" id="load_users_btn"
                data-loading-text="<i class='fa fa-spinner fa-spin '></i> Loading users">Load users
        </button>
        <button type="button" class="btn btn-danger btn-lg" id="clear_users_btn">
            Clear table
        </button>
        <input type="hidden" name="load_users_form[page]" id="load_users_form_page" value="1"/>
        <input type="hidden" name="load_users_form[size]" id="load_users_form_size" value="10"/>
    </form>
</div>

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

<script>
    $(document).ready(function () {
        var columns = [
            'id',
            'name',
            'username',
            'email',
            'age',
            'webPage',
            'role'
        ];
        var tablePopulator = new TablePopulator('list-users-table', columns);

        function handleDelete(userId) {
            $('#user_to_delete')
                .empty()
                .append(userId);

            $('#user_delete_modal').modal();

            var $confirmBtn = $('#user_confirm_delete_btn');
            // remove any previous events
            $confirmBtn.off();
            $confirmBtn.click(function (e) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/ajax/user/" + userId,
                    error: function (req, text, err) {
                        console.log(req);
                        console.log(text);
                        console.log(err);
                        writeMessage('user_list_messages', 'danger', 'Something went wrong. Delete failed!');
                        writeMessage('user_list_messages', 'danger', text);
                    },
                    success: function (response) {
                        if (response.status === 'success') {
                            $('#' + tablePopulator.rowId(userId) + ' td').fadeOut(1000, function () {
                                $(this).remove();
                            });
                            writeMessage('user_list_messages', 'success', response.message);
                        } else {
                            writeMessage('user_list_messages', 'danger', 'Something went wrong. Delete failed!');
                            writeMessage('user_list_messages', 'danger', response.message);
                        }
                    },
                    type: 'DELETE'
                });
            });
        }

        tablePopulator.setDeleteHandler(handleDelete);

        function loadNextUsers() {
            $.ajax({
                url: '${pageContext.request.contextPath}/ajax/user/',
                error: function (req, text, err) {
                    console.log(req);
                    console.log(text);
                    console.log(err);
                },
                data: $("form[name='load_users_form']").serialize(),
                success: function (response) {
                    if (response.status === 'success') {
                        tablePopulator.addEntities(response.items);
                        populateForm('load_users_form', response.next);
                    } else {
                        writeMessage('user_list_messages', 'danger', response.message);
                    }
                },
                type: 'GET'
            });
        }

        $("form[name='load_users_form']").submit(function (e) {
                e.preventDefault();
                var $loadButton = $('#load_users_btn');
                $loadButton.button('loading');
                setTimeout(function () {
                    loadNextUsers();
                    $loadButton.button('reset');
                }, 300);
            }
        );

        $('#clear_users_btn').click(function () {
            tablePopulator.clearTable();
            populateForm('load_users_form', {
                page: 1,
                size: 10
            });
            writeMessage('user_list_messages', 'success', 'Table was cleared.');
        });
    });
</script>