Imports System.Data.SqlClient

Public Class bookshelf
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) Then
            Response.Redirect("login.aspx")
        End If

        If BookNameTextBox.Text = "" Then
            BookNameTextBox.Text = "<所有書目>"
        End If

        UserNameTop.Text = "登入身分: " + Session(Session(cookie("key")))
        UserNameDown.Text = "登入身分: " + Session(Session(cookie("key")))

    End Sub

    Protected Sub LogoutButton_Click(sender As Object, e As EventArgs) Handles LogoutButton.Click

        Session.Clear()
        Response.Cookies.Remove("User_Info")
        Response.Redirect("login.aspx")

    End Sub

    Protected Sub Detail_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        Dim ISBN As String = e.CommandArgument.ToString()
        Session.Add("Selected_Book", ISBN)

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("SELECT * FROM Books WHERE ISBN = @isbn", connection)
        command.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN.Trim()
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        If table.Rows.Count = 1 Then

            Dim BookInfo As DataRow = table.AsEnumerable().First()
            BookImage.ImageUrl = "~/resources/" + BookInfo("bookimage").ToString()
            Name.Text = BookInfo("bookname").ToString()
            Author.Text = BookInfo("author").ToString()
            Publisher.Text = BookInfo("publisher").ToString()
            Year.Text = BookInfo("pubyear").ToString()
            BookNumber.Text = BookInfo("ISBN").ToString()
            Pages.Text = BookInfo("pages").ToString()
            Amount.Text = BookInfo("quantity").ToString()

            SearchHeader.Visible = False
            LibraryWindow.Visible = False
            BookWindow.Visible = True

        End If

    End Sub

    Protected Sub UserBook_Click(sender As Object, e As EventArgs) Handles UserBook.Click

        Response.Redirect("userpanel.aspx")

    End Sub

    Protected Sub SimpleRead_Click(sender As Object, e As EventArgs) Handles SimpleRead.Click



    End Sub

    Protected Sub Borrow_Click(sender As Object, e As EventArgs) Handles Borrow.Click

        Dim ISBN As String = Session("Selected_Book")

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("INSERT INTO [dbo].[LibraryCard]
           ([ISBN]
           ,[username]
           ,[start_date]
           ,[due_date])
     VALUES
           (<ISBN, bigint,>
           ,<username, nvarchar(50),>
           ,<start_date, date,>
           ,<due_date, date,>)", connection)

        command.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN.Trim()
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

    End Sub

    Protected Sub ReturnButton_Click(sender As Object, e As EventArgs) Handles ReturnButton.Click

        SearchHeader.Visible = True
        LibraryWindow.Visible = True
        BookWindow.Visible = False
        Session.Remove("Selected_Book")

    End Sub

End Class