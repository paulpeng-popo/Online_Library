<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="controlpanel.aspx.vb" Inherits="Online_Library.controlpanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel panel-default" style="width: 100vw; height: 98vh; padding: 10px; margin: 0; overflow: hidden;">
            <div id="Tabs" role="tabpanel">
                <div id="LogoutButton" style="float: right; padding: 0 30px 20px 20px">
                    <asp:Button ID="Logout" runat="server" Text="登出" BorderStyle="Solid" Height="30px" Width="100px" />
                </div>
                <ul class="nav nav-tabs" role="tablist">
                    <li class="active"><a href="#users_management" aria-controls="users" role="tab" data-toggle="tab">管理使用者</a></li>
                    <li><a href="#books_CRUD" aria-controls="library" role="tab" data-toggle="tab">管理圖書</a></li>
                    <li><a href="#library_cards" aria-controls="cards" role="tab" data-toggle="tab">管理使用者借閱狀況</a></li>
                </ul>
                <div class="tab-content" style="padding-top: 10px">
                    <div role="tabpanel" class="tab-pane active" id="users_management">
                        <iframe id="iframeUsers" src="users_management.aspx" style="width: 97.5vw; height: 86.5vh; padding: 10px; margin: 0"></iframe>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="books_CRUD">
                        <iframe id="IframeLibrary" src="library_management.aspx" style="width: 97.5vw; height: 86.5vh; padding: 10px; margin: 0"></iframe>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="library_cards">
                        <iframe id="IframeCards" src="cards_management.aspx" style="width: 97.5vw; height: 86.5vh; padding: 10px; margin: 0"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
