<%--
  Created by IntelliJ IDEA.
  User: fpalomo
  Date: 01/06/2021
  Time: 08:45
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<html>
    <head>
        <meta charset="UTF-8">
        <title>404 | ${labels.get('NOT_FOUND', pageContext.request)}</title>
    </head>
    <body>
        <div class="firstWarning">${labels.get('NOT_FOUND', pageContext.request)}</div>
        <img src="css/images/404.jpg" class="imgWarning" />
    </body>
</html>
