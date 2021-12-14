<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="bookshelf.aspx.vb" Inherits="Online_Library.bookshelf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Library System</title>
    <link href="bookshelf.css" rel="stylesheet" />
    <script> history.forward(); </script>
</head>
<body>
    <form id="form1" runat="server">
        <%
            Response.Buffer = True
            Response.Expires = 0
            Response.ExpiresAbsolute = DateTime.Now.AddDays(-1)
            Response.CacheControl = "no-cache"
        %>
        <div class="header-container">
            <div id="BookText" class="choose-block">
                <asp:Label ID="BookName" runat="server" Text="書名(或包含的字詞):" Font-Bold="True" Font-Size="Large"></asp:Label>
                <asp:TextBox ID="BookNameTextBox" runat="server" Text="<所有書目>" Height="18px" Width="300px" AutoPostBack="True"></asp:TextBox>
            </div>
            <div id="ChoseCategory" class="choose-block">
                <asp:Label ID="CategoryLabel" runat="server" Text="選擇分類" Font-Bold="True" Font-Size="Large"></asp:Label>
                <asp:DropDownList ID="CategoryDropDownList" runat="server" Height="25px" AutoPostBack="True" AppendDataBoundItems="true"
                    DataSourceID="CategoryData" DataTextField="category" DataValueField="category">
                    <asp:ListItem Text="<所有種類>" Value="<所有種類>" />
                </asp:DropDownList>
            </div>
            <div id="ChoseYear" class="choose-block">
                <asp:Label ID="YearLabel" runat="server" Text="選擇年分" Font-Bold="True" Font-Size="Large"></asp:Label>
                <asp:DropDownList ID="YearDropDownList" runat="server" Height="25px" AutoPostBack="True" AppendDataBoundItems="true"
                    DataSourceID="YearData" DataTextField="pubyear" DataValueField="pubyear">
                    <asp:ListItem Text="<所有年份>" Value="0" />
                </asp:DropDownList>
            </div>
            <div id="FilterAvailable" class="choose-block">
                <asp:CheckBox ID="AvailableCheckBox" runat="server" Text="只顯示目前可借" Font-Bold="True" Font-Size="Large" AutoPostBack="True" />
            </div>
        </div>
        <div class="body-container">
            <asp:Panel ID="LibraryWindow" runat="server">
                <asp:Repeater ID="DynamicDataTable" runat="server" DataSourceID="BooksData">
                    <HeaderTemplate>
                        <table border="1">
                            <tr>
                                <td><b>編號</b></td>
                                <td><b>書名</b></td>
                                <td><b>作者</b></td>
                                <td><b>書目分類項</b></td>
                                <td><b>出版年份</b></td>
                                <td><b>可借用本數</b></td>
                                <td><b>書本資料及借閱</b></td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Me.DynamicDataTable.Items.Count + 1 %></td>
                            <td><%# Eval("bookname") %></td>
                            <td><%# Eval("author") %></td>
                            <td><%# Eval("category") %></td>
                            <td><%# Eval("pubyear") %></td>
                            <td><%# Eval("quantity") %></td>
                            <td>
                                <asp:Button ID="Details" runat="server" Text="我要借閱" CommandArgument='<%# Eval("ISBN") %>' OnCommand="Detail_Click" /></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="CategoryData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT DISTINCT [category] FROM [Books] ORDER BY [category]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="YearData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT DISTINCT [pubyear] FROM [Books] ORDER BY [pubyear] DESC"></asp:SqlDataSource>
                <asp:SqlDataSource ID="BooksData" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" SelectCommand="SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT [bookname], [author], [category], [ISBN], [pubyear], [quantity] FROM [Books] WHERE [quantity] >= @quantity OR @quantity = 0) AS [QuantityTable] WHERE [QuantityTable].[pubyear] = @pubyear OR @pubyear = 0) AS [YearTable] WHERE [YearTable].[category] = @category OR @category LIKE N'%所有種類%') AS [CategoryTable] WHERE [CategoryTable].[bookname] LIKE '%' + @bookname + '%' OR @bookname LIKE N'%所有書目%' ORDER BY [bookname]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="BookNameTextBox" Name="bookname" Type="String" PropertyName="Text" />
                        <asp:ControlParameter ControlID="CategoryDropDownList" Name="category" Type="String" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="YearDropDownList" Name="pubyear" Type="Int32" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="AvailableCheckBox" Name="quantity" Type="Int32" PropertyName="Checked" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <div class="padding-row"></div>
            <asp:Panel ID="BookWindow" runat="server" Visible="true">
                <div style="display: inline-block">
                    <asp:Image ID="BookImage" runat="server" Height="280px" Width="200px" />
                </div>
                <div style="display: inline-block">
                    <asp:ListView ID="BookDetail" runat="server" style="margin-top: 0px">
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
