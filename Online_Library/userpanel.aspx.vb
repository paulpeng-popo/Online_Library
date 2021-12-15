Public Class userpanel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) Then
            Response.Redirect("login.aspx")
        End If

    End Sub

    Protected Sub SearchBook_Click(sender As Object, e As EventArgs) Handles SearchBook.Click

        Response.Redirect("bookshelf.aspx")

    End Sub

End Class