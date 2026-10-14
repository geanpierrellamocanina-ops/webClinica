<%
    if (request.getSession().getAttribute("error") != null) {
        out.print("<div class='alert alert-danger' role='alert'>" + request.getSession().getAttribute("error") + " </div>");
        request.getSession().setAttribute("error", null);
    }

    if (request.getSession().getAttribute("success") != null) {
        out.print("<div class='alert alert-success' role='alert'>" + request.getSession().getAttribute("success") + " </div>");
        request.getSession().setAttribute("success", null);
    }
%>