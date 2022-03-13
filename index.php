<?php
include_once("fractions.php");
include_once("jsonfiles.php");

$jsonkey = array_rand($jsonarray);
$key = $jsonarray[$jsonkey];
$fraction = $fractionsarray[$key];

$image_uri = "https://ipfs.io/ipfs/$key";
$image_uri_cache = "cache/$key.png";
$metadata_uri = "https://ipfs.io/ipfs/$jsonkey";
$success = false;

$msg = "EMPTY";
$mint_to_address = "0xe915e6fe05f19e38816337cceb287af62452e0f7";
#EddieOhm
#0xc34b7636942152641205b52e6b3a067c4c64721f
$contract_address_rinkeby = "0xf18eE101d2081478ce68Eab4E6B8f7Cb0fBBed4e";
$contract_address_polygon = "0xdf50220f22b75896e38e8f541a00af98d57b1aee";
$contract_address = $contract_address_polygon;

$token_id = rand(1, 300);
$response = "";
$dorob = false;
$chain = "polygon";
$robber_address = "0xe915e6fe05f19e38816337cceb287af62452e0f7";
if (isset($_REQUEST['from'])) {
	$x = $_REQUEST['from'];
	if (ctype_alnum($x) && strlen($x) == 42){
		$robber_address = $_REQUEST['from'];
	}
}
if (isset($_REQUEST['to'])) {
	$x = $_REQUEST['to'];
	if (ctype_alnum($x) && strlen($x) == 42){
		$mint_to_address = $x;
	}
}

if ($_POST['wallet']) {
	$x = $_REQUEST['wallet'];
	if (ctype_alnum($x) && strlen($x) == 42){
		$mint_to_address = $x;
	}
	$dorob = true;
}
else if (isset($_REQUEST['rob'])) {
	$mint_to_address = $_REQUEST['rob'];
	$dorob = true;
}

if ($dorob == true) {
	$curl = curl_init();
	curl_setopt_array($curl, [
		CURLOPT_URL => "https://api.nftport.xyz/v0/mints/customizable",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 30,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
		CURLOPT_POSTFIELDS => "{\n  \"chain\": \"$chain\",\n  \"contract_address\": \"$contract_address\",\n  \"metadata_uri\": \"$metadata_uri\",\"token_id\": $token_id,\n  \"mint_to_address\": \"$mint_to_address\"\n}",
		CURLOPT_HTTPHEADER => [
			"Authorization: YOUR_API_KEY_HERE",
			"Content-Type: application/json"
		],
	]);

	$response = curl_exec($curl);
	$json = json_decode($response, true);

	$err = curl_error($curl);

	curl_close($curl);

	if ($err) {
		//echo "cURL Error #:" . $err;
		$msg = "ROBBERY FAILED " . $json["error"];
	} else {
		//echo $response;
		$msg = "YOU ROBBED " . $json["mint_to_address"];
		$image_to_show = $image_uri;
		$success = true;
	}
	#var_dump($json);
	#die($msg);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Null Zoners vs The Hash Lors</title>
</head>
<body>
    <main>
	<div>
        <h1>Null Zoners vs The Hash Lords</h1>
	<img src="icon.png" alt="icon" width="256" height="256">
        <p>A game made for ETHGlobal hackaton 2022</p>
        <p>There is crypto battle from the future raging in the present.</p>
        <p>Null Zoners are rebels against the evil Hash Lords who have outlawed the use of cryptocurrencies.</p>

	</div>
    <div>response: <?php echo($response); ?></div>
	    <form action="<?php htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post">
		<div>
		<!--
		    <label for="name">Your Polygon Wallet Address:</label>
		    <input type="text" name="from" required="required" placeholder="0x00" width="42"/>
		-->
		    <label for="name">Polygon Wallet to attack: </label>
		    <input type="text" name="wallet" required="required" placeholder="0x00" size="50">
		</div>
		<button type="submit">Attack and nuke it from Orbit</button>
	    </form>
	<div>
	<?php
		if ($success) {
			echo("<h1>You attacked $mint_to_address using the $fraction</h1>");
			echo('<img src="' . $image_uri_cache . '" alt="' . $fraction . '" width="600" height="600">');
			//echo('<a href="k
		}
	?>
	</div>
    </main>
</body>
</html>
