<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="controlpanel.aspx.vb" Inherits="Online_Library.controlpanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel panel-default" style="width: 100vw; height: 100vh; padding: 10px; margin: 0">
            <div id="Tabs" role="tabpanel">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="active"><a href="#personal" aria-controls="personal" role="tab" data-toggle="tab">Personal</a></li>
                    <li><a href="#employment" aria-controls="employment" role="tab" data-toggle="tab">Employment</a></li>
                </ul>
                <div class="tab-content" style="padding-top: 10px">
                    <div role="tabpanel" class="tab-pane active" id="personal">
                        <iframe id="iframePersonal" src="login.aspx" style="width: 98.5vw; height: 90vh; padding: 10px; margin: 0"></iframe>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="employment">
                        <iframe id="IframeEmployment" src="registration.aspx" style="width: 98.5vw; height: 90vh; padding: 10px; margin: 0"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
