 
<%@ page language="java"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
 
<html> 
	<head>
		<title>Add a user</title>
	</head>
	<body>
		<%-- create a html form --%>
		<html:form action="userEdit">
			<%-- print out the form data --%>
			<table border="1">
				<tbody>
				<tr>
					<td>Last name:</td>
					<td><html:text property="lastName" /></td>
				</tr>
				<tr>
					<td>Name:</td>
					<td><html:text property="name" /></td>
				</tr>
				<tr>
					<td>Age:</td>
					<td><html:text property="age" /></td>
				</tr>
				</tbody>
			</table>
			<%-- set the parameter for the dispatch action --%>
			<html:hidden property="do" value="saveUser" />	
			
			<br>
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
