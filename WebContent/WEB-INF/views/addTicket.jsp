<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http:
//www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>

<link rel="icon" href="resources/images/favicon.ico">

<title>Deal with IT | Create Ticket</title>

<link rel="stylesheet"
	href="resources/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">
<link rel="stylesheet"
	href="resources/css/font-icons/entypo/css/entypo.css">
<link rel="stylesheet"
	href="//fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic">
<link rel="stylesheet" href="resources/css/bootstrap.css">
<link rel="stylesheet" href="resources/css/neon-core.css">
<link rel="stylesheet" href="resources/css/neon-theme.css">
<link rel="stylesheet" href="resources/css/neon-forms.css">
<link rel="stylesheet" href="resources/css/custom.css">
<link rel="stylesheet" href="resources/js/datatables/datatables.css">
<link rel="stylesheet" href="resources/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="resources/js/select2/select2.css">
<script src="http://demo.neontheme.com/assets/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" async=""
	src="http://www.google-analytics.com/ga.js"></script>

<script src="resources/js/jquery-1.11.3.min.js"></script>

</head>
<body class="page-body" data-url="http://neon.dev">

	<div class="page-container">
	
		<div class="sidebar-menu">
			<div class="sidebar-menu-inner">

				<header class="logo-env">
				<div class="logo">
					<img src="resources/images/DealWithIT_Logo.png" width="200" alt="" />
				</div>

				<div class="sidebar-mobile-menu visible-xs">
					<a href="#" class="with-animation"> <!-- add class "with-animation" to support animation -->
						<i class="entypo-menu"></i>
					</a>
				</div>

				</header>

				<ul id="main-menu" class="main-menu">
					<!-- add class "multiple-expanded" to allow multiple submenus to open -->
					<!-- class "auto-inherit-active-class" will automatically add "active" class for parent elements who are marked already with class "active" -->

					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
						<li><a href="supportHome"> <i class="entypo-home"></i> <span
								class="title"><strong>Home</strong></span>
						</a></li>
					</sec:authorize>

					<sec:authorize access="hasRole('ROLE_USER')">
						<li><a href="userHome"> <i class="entypo-home"></i> <span
								class="title"><strong>Home</strong></span>
						</a></li>
					</sec:authorize>

					<li><a href="dashboard"> <i class="entypo-docs"></i> <span
							class="title"><strong>Tickets</strong></span>
					</a></li>

					<li><a href="createTicket"> <i class="entypo-plus-circled"></i>
							<span class="title"><strong>Create Ticket</strong></span>
					</a></li>

					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
						<li><a href="createUser"> <i class="entypo-user-add"></i>
								<span class="title"><strong>Create User</strong></span>
						</a></li>
					</sec:authorize>

					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li><a href="createSupport">  <i class="entypo-user-add"></i>
								<span class="title"><strong>Create Support</strong></span>
						</a></li>
					</sec:authorize>
				</ul>
			</div>
		</div>

		<div class="main-content">
			<div class="row">

				<!-- Profile Info and Notifications -->
				<div class="col-md-6 col-sm-8 clearfix">
					<div class="col-md-2" style="padding: 1%">
						<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
							<a href="dashboard" class="btn btn-primary "> <i
								class="entypo-left"></i></a>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_USER')">
							<a href="dashboard" class="btn btn-primary"> <i
								class="entypo-left"></i></a>
						</sec:authorize>
					</div>
					<ul class="user-info pull-left pull-none-xsm">
						<!-- Profile Info -->
						
						<li class="profile-info dropdown">
							
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <img
								src="${user.picture}" alt="" class="img-circle" width="50" /><span class="currentUser">${user.username}</span>
								
						</a>
<!-- NEW -->
							<ul class="dropdown-menu">
								<!-- Reverse Caret -->
								<li class="caret"></li>
								<!-- Edit Profile link -->
								<li><a href="editUser">
										<i class="entypo-pencil"></i></i> Edit Profile
								</a></li>
								<li><a href="editPicture"> <i class="entypo-pencil"></i></i>
										Edit Picture
								</a></li>
							</ul>
<!-- NEW -->
						</li>
					</ul>
					
				</div>
				<div style="float: right;">
					<c:url value="/logout" var="logoutUrl" />
					<form action="${logoutUrl }" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<button type="submit" class="btn btn-primary">
							<i class="entypo-logout"></i> Logout
						</button>
					</form>
				</div>
				
			<br><br><br><br>
			<h3>&nbsp;Create Ticket</h3>
			<br>

			<script type="text/javascript">
				jQuery(window).load(
						function() {
							var $table2 = jQuery("#table-2");

							// Initialize DataTable
							$table2.DataTable({
								"sDom" : "tip",
								"bStateSave" : false,
								"iDisplayLength" : 8,
								"aoColumns" : [ {
									"bSortable" : false
								}, null, null, null, null ],
								"bStateSave" : true
							});

							// Highlighted rows
							$table2.find("tbody input[type=checkbox]").each(
									function(i, el) {
										var $this = $(el), $p = $this
												.closest('tr');

										$(el).on(
												'change',
												function() {
													var is_checked = $this
															.is(':checked');

													$p[is_checked ? 'addClass'
															: 'removeClass']
															('highlight');
												});
									});

							// Replace Checboxes
							$table2.find(".pagination a").click(function(ev) {
								replaceCheckboxes();
							});
						});

				// Sample Function to add new row
				var giCount = 1;

				function fnClickAddRow() {
					jQuery('#table-2')
							.dataTable()
							.fnAddData(
									[
											'<div class="checkbox checkbox-replace"><input type="checkbox" /></div>',
											giCount + ".1", giCount + ".2",
											giCount + ".3", giCount + ".4" ]);
					replaceCheckboxes(); // because there is checkbox, replace it
					giCount++;
				}
			</script>

			<!-- ####################################################################################################### -->

			<div class="row">
				<div class="col-md-12">

					<div class="panel panel-primary" data-collapsed="0">

						<div class="panel-body">

							<form role="form" class="form-horizontal form-groups-bordered validate"
								method="post" action="addTicket">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />

								<sec:authorize access="hasRole('ROLE_USER')">
									<div class="form-group">
										<label for="field-1" class="col-sm-3 control-label">Owner</label>

										<div class="col-sm-5">
											<input type="text" readonly class="form-control" name="owner"
												value="${user.username}">
										</div>
									</div>
								</sec:authorize>

								<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
									<div class="form-group">
										<label for="field-1" class="col-sm-3 control-label">Owner</label>

										<div class="col-sm-5">
											<select type="text" name="owner" class="form-control">

												<c:forEach items="${users}" var="owner">

													<option value="${owner.username}">${owner.username}</option>

												</c:forEach>

											</select>

										</div>
									</div>
								</sec:authorize>

								<div class="form-group">
									<label for="field-1" class="col-sm-3 control-label">Category</label>

									<div class="col-sm-5">
										<select type="text" name="category" class="form-control">

											<c:forEach items="${categories}" var="category">

												<option value="${category.name}">${category.name}</option>

											</c:forEach>

										</select>

									</div>
								</div>


								<div class="form-group">
									<label for="field-1" class="col-sm-3 control-label">Subject</label>

									<div class="col-sm-5">
										<input type="text" class="form-control" name="subject"
											placeholder="Title" data-validate="maxlength[30]" required />
									</div>
								</div>

								<div class="form-group">
									<label for="field-1" class="col-sm-3 control-label">Priority</label>

									<div class="col-sm-5">
										<div class="input-spinner">
											<button type="button" class="btn btn-primary">-</button>
											<input type="text" class="form-control size-1" id="priority"
												value="1" data-min="1" data-max="5" name="priority" readonly>
											<button type="button" class="btn btn-primary">+</button>
										</div>
									</div>

									<script>
										function convert() {
											$('#priority').attr('type',
													'number');
										}
										$(document).ready(convert);
									</script>


								</div>

								<div class="form-group">
									<label for="field-1" class="col-sm-3 control-label">Description</label>

									<div class="col-sm-5">
										<textarea class="form-control" name="description"
											placeholder="max. 1000 characters"
											rows="8" data-validate="maxlength[1000]" required></textarea>
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-5">
										<button type="submit"
											class="btn btn-save">
											<i class="entypo-plus-circled"></i>&nbsp;&nbsp;<strong>Create</strong>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<footer class="main"><strong>Projekt der FH-Joanneum - SWENGA</strong>&nbsp;| by Thomas Ortmann, Nina Spalek, Max Wageneder</footer>
				</div>
				
			</div>
		</div>


		<!-- IMPORTS -->


		<script src="resources/js/gsap/TweenMax.min.js"></script>
		<script
			src="resources/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js"></script>
		<script src="resources/js/bootstrap.js"></script>
		<script src="resources/js/joinable.js"></script>
		<script src="resources/js/resizeable.js"></script>
		<script src="resources/js/neon-api.js"></script>
		<script src="resources/js/datatables/datatables.js"></script>
		<script src="resources/js/select2/select2.min.js"></script>
		<script src="resources/js/neon-chat.js"></script>
		<script src="resources/js/neon-custom.js"></script>
		<script src="resources/js/neon-demo.js"></script>
		<script src="resources/js/jquery.validate.min.js"></script>
</body>
</html>
