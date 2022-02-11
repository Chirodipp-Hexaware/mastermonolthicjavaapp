 
<%@ page language="java"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
 
<html> 
	<head>
		<title>Show user list</title>
	</head>
	<body>
	
	<table border="1">
	<tbody>
	<%-- set the header --%>
	<tr>
		<td>Last name</td>
		<td>Name</td>
		<td>Age</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%-- start with an iterate over the collection users --%>
	<logic:iterate name="userListForm" property="users" id="user">
	<tr>
		<%-- book informations --%>
		<td><bean:write name="user" property="lastName" /></td>
		<td><bean:write name="user" property="name" /></td>
		<td><bean:write name="user" property="age" /></td>
		
		<%-- edit and delete link for each book --%>
		<td><html:link action="userEdit.do?do=editUser" 
					   paramName="user" 
					   paramProperty="id" 
					   paramId="id">Edit</html:link>
		</td>
		<td><html:link action="userEdit.do?do=deleteUser" 
					   paramName="user" 
					   paramProperty="id" 
					   paramId="id">Delete</html:link>
		</td>
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
	
	<br>
	<%-- add and back to menu button --%>
	<html:button property="add" 
				 onclick="location.href='userEdit.do?do=addUser'">Add a new user
	</html:button>
	&nbsp;
	<html:button property="back" 
				 onclick="location.href='default.do'">Back to menu
	</html:button>
	</body>
</html>
