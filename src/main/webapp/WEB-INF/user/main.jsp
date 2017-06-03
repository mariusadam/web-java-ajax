<!DOCTYPE html>
<html>
<head>
    <title> - My Web Application</title>

    <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet"
          type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/ajax.js"></script>
    <script src="${pageContext.request.contextPath}/css/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

    <script>
        $(document).ready(function () {
            initializeBindings('user_form');
        });
    </script>
</head>
<body>
<div class="container">
    <h2>Users management</h2>

    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#list">Users list</a></li>
        <li><a data-toggle="tab" href="#new">Add new user</a></li>
    </ul>

    <div class="tab-content">
        <div id="list" class="tab-pane fade in active">
            <h3>Bellow are the available teams along with their details</h3>
            <div id="user_list_wrapper">
                <jsp:include page="list.jsp"/>
            </div>
        </div>

        <div id="new" class="tab-pane fade">
            <h3>Add a new team to the database</h3>
            <div id="user_form_wrapper">
                <jsp:include page="new.jsp"/>
            </div>
        </div>


    </div>
</div>
</body>
</html>
