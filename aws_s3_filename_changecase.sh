 # Copyright (C) 2020 Cheran Krishnamnoorthy - All Rights Reserved
 # You may use, distribute and modify this code under the
 # terms of the MIT license.
 #
 # You should have received a copy of the license with
 # this file. If not, please write to: cherankrish@gmail.com
 #

bucket=my-bucket-name; #Bucket name
list=$(aws s3api list-objects --bucket $bucket --query 'Contents[].{Key: Key}');
newList=$(echo "${list}" | jq '.[] | .Key' | tr -d \");
for line in $newList
do
	oldCasePath=${bucket}/${line};
	smallCasepath=$(echo "$line" | tr '[:upper:]' '[:lower:]');
	#echo "s3://${oldCasePath}";
	#echo "s3://${bucket}/$smallCasepath";
	if [[ "$oldCasePath" != "${bucket}/$smallCasepath" ]]; then
		echo "processing...$line";
		aws s3 mv "s3://${oldCasePath}" "s3://${bucket}/$smallCasepath"
	fi
	
done;
 
