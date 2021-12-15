<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="userpanel.aspx.vb" Inherits="Online_Library.userpanel" %>

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
                <div id="UserButton" style="float: right; padding: 0 30px 20px 20px">
                    <asp:Button ID="SearchBook" runat="server" Text="我要找書" BorderStyle="Solid" Height="30px" Width="100px" />
                </div>
                <ul class="nav nav-tabs" role="tablist">
                    <li class="active"><a href="#booksborrow" aria-controls="books" role="tab" data-toggle="tab">我目前借閱的書</a></li>
                    <li><a href="#account_settings" aria-controls="settings" role="tab" data-toggle="tab">帳號設定</a></li>
                </ul>
                <div class="tab-content" style="padding-top: 10px">
                    <div role="tabpanel" class="tab-pane active" id="booksborrow">
                        <iframe id="iframeBooks" src="mybook.aspx" style="width: 97.5vw; height: 86.5vh; padding: 10px; margin: 0"></iframe>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="account_settings">
                        <iframe id="IframeSettings" src="user_settings.aspx" style="width: 97.5vw; height: 86.5vh; padding: 10px; margin: 0"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
