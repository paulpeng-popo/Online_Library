<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="library_management.aspx.vb" Inherits="Online_Library.library_management" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" AutoGenerateRows="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="ISBN" DataSourceID="Books" Height="50px" Width="1404px">
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <Fields>
                    <asp:BoundField DataField="bookname" HeaderText="書名" SortExpression="bookname" />
                    <asp:BoundField DataField="author" HeaderText="作者" SortExpression="author" />
                    <asp:BoundField DataField="publisher" HeaderText="出版社" SortExpression="publisher" />
                    <asp:BoundField DataField="pubyear" HeaderText="出版年份" SortExpression="pubyear" />
                    <asp:BoundField DataField="ISBN" HeaderText="國際標準書號" ReadOnly="True" SortExpression="ISBN" />
                    <asp:BoundField DataField="category" HeaderText="分類項目" SortExpression="category" />
                    <asp:BoundField DataField="pages" HeaderText="總頁數" SortExpression="pages" />
                    <asp:BoundField DataField="quantity" HeaderText="可借數量" SortExpression="quantity" />
                    <asp:BoundField DataField="bookimage" HeaderText="圖片檔名" SortExpression="bookimage" />
                    <asp:BoundField DataField="abstract" HeaderText="書本介紹" SortExpression="abstract" />
                    <asp:CommandField CancelText="取消" DeleteText="刪除" EditText="編輯" InsertText="確定新增" NewText="加入新書" SelectText="選取" ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" UpdateText="更新" />
                </Fields>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="Books" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:LibraryConnectionString %>" DeleteCommand="DELETE FROM [Books] WHERE [ISBN] = @original_ISBN AND [bookname] = @original_bookname AND (([author] = @original_author) OR ([author] IS NULL AND @original_author IS NULL)) AND [publisher] = @original_publisher AND (([pubyear] = @original_pubyear) OR ([pubyear] IS NULL AND @original_pubyear IS NULL)) AND [category] = @original_category AND (([pages] = @original_pages) OR ([pages] IS NULL AND @original_pages IS NULL)) AND [quantity] = @original_quantity AND (([bookimage] = @original_bookimage) OR ([bookimage] IS NULL AND @original_bookimage IS NULL)) AND [abstract] = @original_abstract" InsertCommand="INSERT INTO [Books] ([bookname], [author], [publisher], [pubyear], [ISBN], [category], [pages], [quantity], [bookimage], [abstract]) VALUES (@bookname, @author, @publisher, @pubyear, @ISBN, @category, @pages, @quantity, @bookimage, @abstract)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Books] ORDER BY [ISBN]" UpdateCommand="UPDATE [Books] SET [bookname] = @bookname, [author] = @author, [publisher] = @publisher, [pubyear] = @pubyear, [category] = @category, [pages] = @pages, [quantity] = @quantity, [bookimage] = @bookimage, [abstract] = @abstract WHERE [ISBN] = @original_ISBN AND [bookname] = @original_bookname AND (([author] = @original_author) OR ([author] IS NULL AND @original_author IS NULL)) AND [publisher] = @original_publisher AND (([pubyear] = @original_pubyear) OR ([pubyear] IS NULL AND @original_pubyear IS NULL)) AND [category] = @original_category AND (([pages] = @original_pages) OR ([pages] IS NULL AND @original_pages IS NULL)) AND [quantity] = @original_quantity AND (([bookimage] = @original_bookimage) OR ([bookimage] IS NULL AND @original_bookimage IS NULL)) AND [abstract] = @original_abstract">
                <DeleteParameters>
                    <asp:Parameter Name="original_ISBN" Type="Int64" />
                    <asp:Parameter Name="original_bookname" Type="String" />
                    <asp:Parameter Name="original_author" Type="String" />
                    <asp:Parameter Name="original_publisher" Type="String" />
                    <asp:Parameter Name="original_pubyear" Type="Int32" />
                    <asp:Parameter Name="original_category" Type="String" />
                    <asp:Parameter Name="original_pages" Type="Int32" />
                    <asp:Parameter Name="original_quantity" Type="Int32" />
                    <asp:Parameter Name="original_bookimage" Type="String" />
                    <asp:Parameter Name="original_abstract" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="bookname" Type="String" />
                    <asp:Parameter Name="author" Type="String" />
                    <asp:Parameter Name="publisher" Type="String" />
                    <asp:Parameter Name="pubyear" Type="Int32" />
                    <asp:Parameter Name="ISBN" Type="Int64" />
                    <asp:Parameter Name="category" Type="String" />
                    <asp:Parameter Name="pages" Type="Int32" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="bookimage" Type="String" />
                    <asp:Parameter Name="abstract" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="bookname" Type="String" />
                    <asp:Parameter Name="author" Type="String" />
                    <asp:Parameter Name="publisher" Type="String" />
                    <asp:Parameter Name="pubyear" Type="Int32" />
                    <asp:Parameter Name="category" Type="String" />
                    <asp:Parameter Name="pages" Type="Int32" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="bookimage" Type="String" />
                    <asp:Parameter Name="abstract" Type="String" />
                    <asp:Parameter Name="original_ISBN" Type="Int64" />
                    <asp:Parameter Name="original_bookname" Type="String" />
                    <asp:Parameter Name="original_author" Type="String" />
                    <asp:Parameter Name="original_publisher" Type="String" />
                    <asp:Parameter Name="original_pubyear" Type="Int32" />
                    <asp:Parameter Name="original_category" Type="String" />
                    <asp:Parameter Name="original_pages" Type="Int32" />
                    <asp:Parameter Name="original_quantity" Type="Int32" />
                    <asp:Parameter Name="original_bookimage" Type="String" />
                    <asp:Parameter Name="original_abstract" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
