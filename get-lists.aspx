<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Xml" %>

<!DOCTYPE html>

<script runat="server">
    // Author: Arda Basoglu
    // Email: arda@directiq.com

    public static HttpWebRequest CreateWebRequest()
    {
        var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://api.directiq.com/v2.asmx?op=GetLists");
        httpWebRequest.Headers.Add("SOAP:Action");
        httpWebRequest.ContentType = "text/xml;charset=\"utf-8\"";
        httpWebRequest.Accept = "text/xml";
        httpWebRequest.Method = "POST";
        return httpWebRequest;
    }

    public void CallTheService()
    {
        // Use your own api key here. This is just an example.
        const string apiKey = "d7a04479-3f0s-44ff-8aaf-2c626df1c4a1";

        var httpWebRequest = CreateWebRequest();
        var xmlDocument = new XmlDocument();
        xmlDocument.LoadXml(string.Format("<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLists xmlns=\"http://api.directiq.com/\"><apiKey>{0}</apiKey></GetLists></soap:Body></soap:Envelope>", apiKey));

        using (var stream = httpWebRequest.GetRequestStream())
        {
            xmlDocument.Save(stream);
        }

        using (var response = httpWebRequest.GetResponse())
        {
            using (var rd = new StreamReader(response.GetResponseStream()))
            {
                var soapResult = rd.ReadToEnd();
                var encodedXml = string.Format(HttpUtility.HtmlEncode(soapResult));
                LiteralResult.Text = encodedXml;
            }
        }
    }

    protected void ButtonCallClick(object sender, EventArgs e)
    {
        CallTheService();
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"></head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="ButtonCall" runat="server" Text="Get Your DirectIQ Lists" OnClick="ButtonCallClick" />
            <pre>
                <asp:Literal ID="LiteralResult" runat="server" />
            </pre>
        </div>
    </form>
</body>
</html>
