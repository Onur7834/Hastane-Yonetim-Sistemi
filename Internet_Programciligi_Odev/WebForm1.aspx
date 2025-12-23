<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Internet_Programciligi_Odev.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kullanıcı Girişi</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            width: 320px;
            text-align: center;
        }

        .input-field {
            width: 100%;
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .login-button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .login-button:hover {
            background-color: #218838;
        }

        .error-message {
            color: red;
            font-size: 0.8em;
            margin-bottom: 10px;
            display: block;
        }

        .links {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .links a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9em;
            cursor: pointer;
        }

        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">
    <div class="login-container">
        <h2>Giriş Yap</h2>

        <asp:Label ID="lblHata" runat="server" CssClass="error-message"></asp:Label>

        <asp:TextBox ID="txtKullanici" runat="server"
            CssClass="input-field"
            placeholder="Kullanıcı Adı"></asp:TextBox>

        <asp:TextBox ID="txtSifre" runat="server"
            CssClass="input-field"
            TextMode="Password"
            placeholder="Şifre"></asp:TextBox>

        <asp:TextBox ID="txtDogrulamaKodu" runat="server"
            CssClass="input-field"
            placeholder="Doğrulama Kodunu Giriniz"
            Visible="false"
            Style="border: 2px solid #ffc107; background-color: #fff9e6;">
        </asp:TextBox>

        <asp:Button ID="btnGiris" runat="server"
            Text="Giriş Yap"
            CssClass="login-button"
            OnClick="btnGiris_Click" />


        <div class="links">
            <asp:LinkButton ID="lnkSifremiUnuttum" runat="server"
                OnClick="lnkSifremiUnuttum_Click">
                Şifremi Unuttum
            </asp:LinkButton>

            <asp:LinkButton ID="lnkKayitOl" runat="server"
                OnClick="lnkKayitOl_Click">
                Kayıt Ol
            </asp:LinkButton>
        </div>

    </div>
</form>
</body>
</html>
