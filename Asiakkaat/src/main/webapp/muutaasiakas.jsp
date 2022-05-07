<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src = "http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href= "css/main.css">
<title>Asiakkaan muuttaminen</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle">
				<th><input type = "button" value = "Takaisin listaukseen" id="takaisin"></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type= "text" name="etunimi" id="etunimi"></td>
				<td><input type= "text" name="sukunimi" id="sukunimi"></td>
				<td><input type= "text" name="puhelin" id="puhelin"></td>
				<td><input type= "text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="tallenna" value = "Hyv�ksy"></td>
			</tr>
		</tbody>
		</table>
		<input type="hidden" name="asiakas_id" id="asiakas_id">
	</form>
	<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	var asiakas_id = requestURLParam("asiakas_id");
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);
		$("#asiakas_id").val(result.asiakas_id);
	}});
	
	$("#tiedot").validate({
		rules: {
			etunimi: {
				required: true
			},
			sukunimi: { 
				required: true
			},
			puhelin: {
				required: true,
				number: true,
				minlength: 7
			},
			sposti: {
				required: true,
				email: true
			}
		},
		messages: {
			etunimi: {
				required: "Puuttuu"
			},
			sukunimi: {
				required: "Puuttuu"
			},
			puhelin: {
				required: "Puuttuu",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
		submitHandler: function(form) {
			paivitaTiedot();
		}
	});
});

function paivitaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", success:function(result) {
		if(result.response==0){
			$("#ilmo").html("Asiakkaan p�ivitt�minen ep�onnistui.");
		}else if(result.response==1){
			$("#ilmo").html("Asiakkaan p�ivitt�minen onnistui.");
			}
	}});
}
</script>
</html>