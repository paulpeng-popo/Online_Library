Imports System.Data.SqlClient

Public Class bookshelf
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim cookie As HttpCookie = Request.Cookies("User_Info")
        'If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) Then
        'Response.Redirect("login.aspx")
        'End If

        If BookNameTextBox.Text = "" Then
            BookNameTextBox.Text = "<所有書目>"
        End If

    End Sub

    Protected Sub Detail_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        Dim ISBN As String = e.CommandArgument.ToString()

        Dim connection As New SqlConnection("Server = paul\sqlexpress; Database = Library; Integrated Security = true")
        Dim command As New SqlCommand("SELECT * FROM Books WHERE ISBN = @isbn", connection)
        command.Parameters.Add("@isbn", SqlDbType.BigInt).Value = ISBN.Trim()
        Dim adapter As New SqlDataAdapter(command)
        Dim table As New DataTable()
        adapter.Fill(table)

        If table.Rows.Count = 1 Then

            Dim BookInfo As DataRow = table.AsEnumerable().First()
            MsgBox(BookInfo("bookname").ToString())

        End If

    End Sub

End Class