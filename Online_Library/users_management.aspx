<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="users_management.aspx.vb" Inherits="Online_Library.users_management" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84"
                BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="username" DataSourceID="database_users">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="username" HeaderText="username" ReadOnly="True" SortExpression="username" />
                    <asp:BoundField DataField="target_string" HeaderText="target_string" SortExpression="target_string" />
                    <asp:BoundField DataField="email_address" HeaderText="email_address" SortExpression="email_address" />
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
            <asp:SqlDataSource ID="database_users" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>"
                DeleteCommand="DELETE FROM [Users] WHERE [username] = @original_username AND [target_string] = @original_target_string AND [email_address] = @original_email_address"
                InsertCommand="INSERT INTO [Users] ([username], [target_string], [email_address]) VALUES (@username, @target_string, @email_address)"
                OldValuesParameterFormatString="original_{0}"
                SelectCommand="SELECT * FROM [Users] ORDER BY [username]"
                UpdateCommand="UPDATE [Users] SET [target_string] = @target_string, [email_address] = @email_address WHERE [username] = @original_username AND [target_string] = @original_target_string AND [email_address] = @original_email_address">
                <DeleteParameters>
                    <asp:Parameter Name="original_username" Type="String" />
                    <asp:Parameter Name="original_target_string" Type="String" />
                    <asp:Parameter Name="original_email_address" Type="String" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="target_string" ConvertEmptyStringToNull="false" Type="String" />
                    <asp:Parameter Name="email_address" ConvertEmptyStringToNull="false" Type="String" />
                    <asp:Parameter Name="original_username" Type="String" />
                    <asp:Parameter Name="original_target_string" Type="String" />
                    <asp:Parameter Name="original_email_address" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
