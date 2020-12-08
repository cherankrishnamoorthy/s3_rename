bucket=webshots-new-2;
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
 