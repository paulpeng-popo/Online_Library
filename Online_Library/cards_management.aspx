<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="cards_management.aspx.vb" Inherits="Online_Library.cards_management" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ISBN,username" DataSourceID="Cards" ForeColor="#333333" GridLines="None" Height="236px" Width="1010px">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="ISBN" HeaderText="國際標準書號" ReadOnly="True" SortExpression="ISBN" />
                    <asp:BoundField DataField="username" HeaderText="使用者名稱" ReadOnly="True" SortExpression="username" />
                    <asp:BoundField DataField="start_date" HeaderText="借書日" SortExpression="start_date" />
                    <asp:BoundField DataField="due_date" HeaderText="到期日" SortExpression="due_date" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
            <asp:SqlDataSource ID="Cards" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT * FROM [LibraryCard] ORDER BY [due_date]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
