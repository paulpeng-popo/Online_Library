<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="users_management.aspx.vb" Inherits="Online_Library.users_management" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="username" DataSourceID="Users" Height="309px" Width="681px">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CancelText="取消" DeleteText="刪除" EditText="編輯" InsertText="確認新增" NewText="加入新使用者" SelectText="選取" UpdateText="更新" />
                    <asp:BoundField DataField="username" HeaderText="使用者名稱" ReadOnly="True" SortExpression="username" />
                    <asp:BoundField DataField="email_address" HeaderText="電子郵件" SortExpression="email_address" />
                </Columns>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FFF1D4" />
                <SortedAscendingHeaderStyle BackColor="#B95C30" />
                <SortedDescendingCellStyle BackColor="#F1E5CE" />
                <SortedDescendingHeaderStyle BackColor="#93451F" />
            </asp:GridView>
        </div>
        <asp:SqlDataSource ID="Users" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" DeleteCommand="DELETE FROM [Users] WHERE [username] = @username AND NOT EXISTS (SELECT [LibraryCard].[username] FROM [LibraryCard] WHERE [Users].[username] = [LibraryCard].[username])" SelectCommand="SELECT [username], [email_address] FROM [Users]" UpdateCommand="UPDATE [Users] SET [email_address] = @email_address WHERE [username] = @username">
            <DeleteParameters>
                <asp:Parameter Name="username" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="email_address" Type="String" />
                <asp:Parameter Name="username" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
