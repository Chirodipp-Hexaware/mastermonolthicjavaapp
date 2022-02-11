 
<%@ page language="java"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
 
<html> 
	<head>
		<title>Show book list</title>
	</head>
	<body>
	
	<table border="1">
	<tbody>
	<%-- set the header --%>
	<tr>
		<td>Author</td>
		<td>Book name</td>
		<td>Available</td>
		<td>Borrow by</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%-- start with an iterate over the collection books --%>
	<logic:iterate name="bookListForm" property="bookViews" id="book">
	<tr>
		<%-- book informations --%>
		<td><bean:write name="book" property="author" /></td>
		<td><bean:write name="book" property="title" /></td>
		<td><html:checkbox disabled="true" 
						   name="book" 
						   property="available"/>
		</td>
		<td>
			<%-- check if a user borrowed a book, 
				 when its true display his name 
				 otherwise display nothing --%>
			<logic:notEmpty name="book" property="userView.name">
				<bean:write name="book" property="userView.name" />, 
				<bean:write name="book" property="userView.lastName" />
			</logic:notEmpty>
			<logic:empty name="book" property="userView.name">
				-
			</logic:empty>
		</td>
		<%-- lent, edit and delete link for each book --%>
		<td>
			<%-- check if a user borrowed a book, 
				 when its true display the return link
				 otherwise display the borrow link --%>
			<logic:notEmpty name="book" property="userView.name">
				<html:link action="bookEdit.do?do=returnBook" 
							   paramName="book" 
							   paramProperty="id" 
							   paramId="id">Return book</html:link>	
			</logic:notEmpty>
			<logic:empty name="book" property="userView.name">
				<html:link action="bookEdit.do?do=borrowBook" 
							   paramName="book" 
							   paramProperty="id" 
							   paramId="id">Borrow book</html:link>
			</logic:empty>
		</td>
		<td><html:link action="bookEdit.do?do=editBook" 
					   paramName="book" 
					   paramProperty="id" 
					   paramId="id">Edit</html:link>
		</td>
		<td><html:link action="bookEdit.do?do=deleteBook" 
					   paramName="book" 
					   paramProperty="id" 
					   paramId="id">Delete</html:link>
		</td>
	</tr>
	</logic:iterate> 
	<%-- end interate --%>
	
	<%-- if books cannot be found display a text --%>
	<logic:notPresent name="book">
		<tr>
			<td colspan="5">No books found.</td>
		</tr>
	</logic:notPresent>	
	
	</tbody>
	</table>
	
	<br>
	<%-- add and back to menu button --%>
	<html:button property="add" 
				 onclick="location.href='bookEdit.do?do=addBook'">Add a new book
	</html:button>
	&nbsp;
	<html:button property="back" 
				 onclick="location.href='default.do'">Back to menu
	</html:button>
	</body>
</html>
