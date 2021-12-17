Public Class controlpanel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookie As HttpCookie = Request.Cookies("User_Info")
        If cookie Is Nothing OrElse cookie("value") <> Session(cookie("key")) OrElse cookie("identity") <> "admin" Then
            Response.Redirect("login.aspx")
        End If

    End Sub

    Protected Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click

        Session.Clear()
        Response.Cookies.Remove("User_Info")
        Response.Redirect("login.aspx")

    End Sub

End Class