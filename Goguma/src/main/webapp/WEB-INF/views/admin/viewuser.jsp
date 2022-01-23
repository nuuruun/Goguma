<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고구마장터</title>
<%@ include file="/WEB-INF/views/inc/asset.jsp"%>
<style>

	.table .user-img {
		text-align: center;
		vertical-align: middle;
	}
	
	.table .user-info p {
		margin-bottom: 3px;
	}
	
	.table .user-info .info-title {
		display: inline-block;
		width: 100px;
		margin-left: 50px;
		margin-right: 25px;
		background-color: #EEE;
		color: #333;
	}
	
	.table .user-info .info-title + span {
		color: #333;
	}
	
</style>
</head>
<body>
	<!-- block.jsp -->
	<main class="main">
		<%-- <%@include file="/WEB-INF/views/inc/header.jsp"%> --%>
		<section class="content">
			<%-- <%@ include file="/WEB-INF/views/inc/admin/nav.jsp"%> --%>
			<div class="user-title">
				<p>${dto.name}(${dto.id})님의회원정보</p>
			</div>

			<table class="table table-bordered">
				<tr>
					<td class="user-img"><img
						src="/goguma/asset/img/logo_goguma_.png" style="width: 130px"></td>
					<td class="user-info">
						<p>
							<span class="info-title">아이디</span><span>${dto.id}</span>
						</p>
						<p>
							<span class="info-title">이름</span><span>${dto.name}</span>
						</p>
						<p>
							<span class="info-title">닉네임</span><span>${dto.nickname}</span>
						</p>
						<p>
							<span class="info-title">전화번호</span><span>${dto.tel}</span>
						</p>
						<p>
							<span class="info-title">이메일</span><span>${dto.email}</span>
						</p>
						<p>
							<span class="info-title">주소</span><span>${dto.address}</span>
						</p>
						<p>
							<span class="info-title">생년월일</span><span>${dto.birth}</span>
						</p>
						<p>
							<span class="info-title">가입일</span><span>${dto.since}</span>
						</p>
						<p>
							<span class="info-title">평점</span><span>${dto.score}</span>
						</p>
						<p>
							<span class="info-title">상태</span><span>${dto.state}</span>
						</p>
					</td>
				</tr>
			</table>

			<div role="tabpanel">

				<!-- Nav tabs -->
				<ul class="nav nav-pills" role="tablist">
					<li role="presentation" class="active">
						<a href="#home" aria-controls="home" role="tab" data-toggle="tab">거래내역</a>
					</li>
					<li role="presentation">
						<a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">작성글</a>
					</li>
					<li role="presentation">
						<a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">작성댓글</a>
					</li>
					<li role="presentation">
						<a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">문의내역</a>
					</li>
				
				</ul>

				<!-- Tab panes -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="home">
						<table class="table table-bordered">
							<tr>
								<th>번호</th>
								<th>구분</th>
								<th>상태</th>
								<th>상품이름</th>
								<th>거래자 아이디</th>
								<th>거래날짜</th>
							</tr>
						</table>
					</div>
					<div role="tabpanel" class="tab-pane" id="profile">
						<table class="table table-bordered">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성날짜</th>
							</tr>
						</table>
					</div>
					<div role="tabpanel" class="tab-pane" id="messages">
						<table class="table table-bordered">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>댓글내용</th>
								<th>작성날짜</th>
							</tr>
						</table>
					</div>
					<div role="tabpanel" class="tab-pane" id="settings">
						<table class="table table-bordered">
							<tr>
								<th>번호</th>
								<th>문의유형</th>
								<th>제목</th>
								<th>상태</th>
								<th>작성날짜</th>
							</tr>
						</table>
					</div>
				</div>

			</div>

		</section>

		<%-- <%@include file="/WEB-INF/views/inc/footer.jsp" %> --%>

	</main>

	<script>
		
	</script>
</body>
</html>