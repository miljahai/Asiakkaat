<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakaslista</title>
<style>
.oikealle{
		text-align: right;
	}
</style>
</head>
<body>
<table id = "listaus">
	<thead>
		<tr>
			<th colspan = "4" class ="oikealle">
			<th><input type = "button" value ="Lisää uusi asiakas" id = "uusiAsiakas"></th>
		</tr>
		<tr>
			<th class = "oikealle">Hakusana:</th>
			<th colspan ="3"><input type = "text" id = "hakusana"></th>
			<th><input type = "button" value = "Hae" id = "hakunappi"></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<span id="ilmo"></span>
<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();	
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();
	
});

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success: function(result){
		$.each(result.asiakkaat, function(i, field){
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<td>"+field.etunimi+"</td>";
			htmlStr+="<td>"+field.sukunimi+"</td>";
			htmlStr+="<td>"+field.puhelin+"</td>";
			htmlStr+="<td>"+field.sposti+"</td>";
			htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+")>Poista</span></td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}
function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id + "?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType: "json", success:function(result) {
			if(result.response==0){
				$("#ilmo").html("Asiakkaan poisto epäonnistui.");
			}else if(result.response==1){
				$("#rivi_"+asiakas_id).css("background-color", "red"); 
				$("#ilmo").html("Asiakkaan " + asiakas_id + " poisto onnistui");
				haeAsiakkaat();
			}
		}});
	}
}
</script>
</body>
</html>