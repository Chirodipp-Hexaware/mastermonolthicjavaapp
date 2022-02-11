 
<%@ page language="java"%>
<%@ page isELIgnored="false"%>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
 
<html> 
	<head>
		<title>Show user</title>
	</head>
	<body>
	<html:form action="bookEdit">
	<table border="1">
	<tbody>
	<%-- set the header --%>
	<tr>
		<td>Last name</td>
		<td>Name</td>
		<td>Lent</td>
	</tr>
	
	<%-- start with an iterate over the collection users --%>
	<logic:iterate name="users" id="user">
	<tr>
		<%-- book informations --%>
		<td><bean:write name="user" property="lastName" /></td>
		<td><bean:write name="user" property="name" /></td>
		<td><html:radio property="userId" value="${user.id}" /></td>
	</tr>
	</logic:iterate> 
	<%-- end interate --%>
	
	<%-- if users cannot be found display a text --%>
	<logic:notPresent name="user">
		<tr>
			<td colspan="5">No users found.</td>
		</tr>
	</logic:notPresent>	
	</tbody>
	</table>
	
	<%-- set the book id to lent --%>
	<html:hidden property="id" />
	
	<%-- set the parameter for the dispatch action --%>
	<html:hidden property="do" value="saveBorrow" />	
	
	<%-- submit and back button --%>
	<html:button property="back" 
				 onclick="history.back();">
				 Back
	</html:button>
	&nbsp;
	<html:submit>Save</html:submit>
	</html:form>
	</body>
</html>
