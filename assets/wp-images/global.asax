<%@ Application Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.IO.Compression" %>

<script runat="server">
void Application_BeginRequest(object sender, EventArgs e)
{
	HttpApplication app = (HttpApplication)sender;
	string acceptEncoding = app.Request.Headers["Accept-Encoding"];
	Stream prevUncompressedStream = app.Response.Filter;

	if (acceptEncoding == null || acceptEncoding.Length == 0)
		return;

	acceptEncoding = acceptEncoding.ToLower();

	if (acceptEncoding.Contains("gzip"))
	{
		// gzip
		app.Response.Filter = new GZipStream(prevUncompressedStream,
			CompressionMode.Compress);
		app.Response.AppendHeader("Content-Encoding",
			"gzip");
	}
	else if (acceptEncoding.Contains("deflate"))
	{
		// deflate
		app.Response.Filter = new DeflateStream(prevUncompressedStream,
			CompressionMode.Compress);
		app.Response.AppendHeader("Content-Encoding",
			"deflate");
	}
}
</script>