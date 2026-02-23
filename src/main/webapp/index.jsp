<%
    String message = System.getenv("APP_MESSAGE");
    if (message == null || message.isEmpty()) {
        message = "Default Message - Env Not Loaded";
    }

    String user = System.getenv("DB_USERNAME");
    String pass = System.getenv("DB_PASSWORD");
%>

<h1><%= message %></h1>
<h3>DB User: <%= user %></h3>
<h3>DB Password: <%= pass %></h3>
